# iOSIntPackage

Учебный __Swift Package__

Содержимое пакета:
1. `ImageProcessor` - сущность для применения CIFilter к изображению, действует синхронно и асинхронно 
2. `Images` - небольшое хранилище с образцами фото
3. `ImagePublisher` с протоколом `ImageLibrarySubscriber` - сущность для тренировки протокола `Observer` с имитацией реактивного обновления UIImage при помощи таймера 
