from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('expenses', '0004_tw_withdrawal_type'),
    ]

    operations = [
        migrations.AddField(
            model_name='transaction',
            name='discount_amount',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=12, null=True),
        ),
    ]
