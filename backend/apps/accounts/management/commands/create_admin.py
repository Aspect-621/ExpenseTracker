from django.core.management.base import BaseCommand
from django.conf import settings


class Command(BaseCommand):
    help = 'Create default admin user if not exists'

    def handle(self, *args, **options):
        from apps.accounts.models import User
        username = getattr(settings, 'ADMIN_USERNAME', 'admin')
        password = getattr(settings, 'ADMIN_PASSWORD', 'admin123')
        email = getattr(settings, 'ADMIN_EMAIL', 'admin@example.com')

        if not User.objects.filter(username=username).exists():
            User.objects.create_superuser(
                username=username,
                email=email,
                password=password,
                role='admin',
                display_name='Admin'
            )
            self.stdout.write(self.style.SUCCESS(f'Admin user "{username}" created.'))
        else:
            # Ensure existing admin has correct role
            user = User.objects.get(username=username)
            if user.role != 'admin':
                user.role = 'admin'
                user.save()
            self.stdout.write(f'Admin user "{username}" already exists.')
