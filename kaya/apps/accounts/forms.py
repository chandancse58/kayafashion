from django import forms
from django.contrib.auth.password_validation import validate_password
from .models import Customer, Address

class CustomerRegistrationForm(forms.ModelForm):
    # User Details
    name = models.CharField if False else forms.CharField(max_length=150, required=True, label="Full Name")
    username = forms.CharField(max_length=150, required=True)
    email = forms.EmailField(required=True)
    mobile = forms.CharField(max_length=10, required=True)
    
    # Password Fields
    password = forms.CharField(widget=forms.PasswordInput(), validators=[validate_password])
    confirm_password = forms.CharField(widget=forms.PasswordInput(), label="Confirm Password")

    # Address Details
    address = forms.CharField(widget=forms.Textarea(attrs={'rows': 3}), label="Address")
    state = forms.CharField(max_length=100)
    city = forms.CharField(max_length=100)
    pincode = forms.CharField(max_length=6)

    class Meta:
        model = Customer
        fields = ['name', 'username', 'email', 'mobile']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        for field_name, field in self.fields.items():
            field.widget.attrs['class'] = 'form-control'

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if Customer.objects.filter(email=email).exists():
            raise forms.ValidationError("A user with this email already exists.")
        return email

    def clean(self):
        cleaned_data = super().clean()
        password = cleaned_data.get("password")
        confirm_password = cleaned_data.get("confirm_password")

        if password and confirm_password and password != confirm_password:
            self.add_error('confirm_password', "Passwords do not match.")
        return cleaned_data

    def save(self, commit=True):
        customer = super().save(commit=False)
        # Map full name to first_name
        customer.first_name = self.cleaned_data['name']
        customer.set_password(self.cleaned_data['password'])
        
        if commit:
            customer.save()
            # Create default address entry
            Address.objects.create(
                customer=customer,
                address_line=self.cleaned_data['address'],
                state=self.cleaned_data['state'],
                city=self.cleaned_data['city'],
                pincode=self.cleaned_data['pincode'],
                is_default=True
            )
        return customer