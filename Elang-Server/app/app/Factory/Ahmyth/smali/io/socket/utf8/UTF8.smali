.class public final Lio/socket/utf8/UTF8;
.super Ljava/lang/Object;
.source "UTF8.java"


# static fields
.field private static final INVALID_CONTINUATION_BYTE:Ljava/lang/String; = "Invalid continuation byte"

.field private static byteArray:[I

.field private static byteCount:I

.field private static byteIndex:I


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static checkScalarValue(I)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    const v0, 0xd800

    if-lt p0, v0, :cond_1

    const v0, 0xdfff

    if-le p0, v0, :cond_0

    goto :goto_0

    .line 163
    :cond_0
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Lone surrogate U+"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    .line 164
    invoke-static {p0}, Ljava/lang/Integer;->toHexString(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    const-string v1, " is not a scalar value"

    invoke-virtual {p0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_1
    :goto_0
    return-void
.end method

.method private static createByte(II)[C
    .locals 0

    shr-int/2addr p0, p1

    and-int/lit8 p0, p0, 0x3f

    or-int/lit16 p0, p0, 0x80

    .line 78
    invoke-static {p0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object p0

    return-object p0
.end method

.method public static decode(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .line 34
    invoke-static {p0}, Lio/socket/utf8/UTF8;->ucs2decode(Ljava/lang/String;)[I

    move-result-object p0

    sput-object p0, Lio/socket/utf8/UTF8;->byteArray:[I

    .line 35
    array-length p0, p0

    sput p0, Lio/socket/utf8/UTF8;->byteCount:I

    const/4 p0, 0x0

    .line 36
    sput p0, Lio/socket/utf8/UTF8;->byteIndex:I

    .line 37
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    .line 39
    :goto_0
    invoke-static {}, Lio/socket/utf8/UTF8;->decodeSymbol()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_0

    .line 40
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-interface {p0, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 42
    :cond_0
    invoke-static {p0}, Lio/socket/utf8/UTF8;->listToArray(Ljava/util/List;)[I

    move-result-object p0

    invoke-static {p0}, Lio/socket/utf8/UTF8;->ucs2encode([I)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static decodeSymbol()I
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .line 88
    sget v0, Lio/socket/utf8/UTF8;->byteIndex:I

    sget v1, Lio/socket/utf8/UTF8;->byteCount:I

    if-gt v0, v1, :cond_7

    if-ne v0, v1, :cond_0

    const/4 v0, -0x1

    return v0

    .line 96
    :cond_0
    sget-object v1, Lio/socket/utf8/UTF8;->byteArray:[I

    aget v1, v1, v0

    and-int/lit16 v1, v1, 0xff

    add-int/lit8 v0, v0, 0x1

    .line 97
    sput v0, Lio/socket/utf8/UTF8;->byteIndex:I

    and-int/lit16 v0, v1, 0x80

    if-nez v0, :cond_1

    return v1

    :cond_1
    and-int/lit16 v0, v1, 0xe0

    const/16 v2, 0xc0

    const-string v3, "Invalid continuation byte"

    if-ne v0, v2, :cond_3

    .line 104
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v0

    and-int/lit8 v1, v1, 0x1f

    shl-int/lit8 v1, v1, 0x6

    or-int/2addr v0, v1

    const/16 v1, 0x80

    if-lt v0, v1, :cond_2

    return v0

    .line 109
    :cond_2
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    invoke-direct {v0, v3}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_3
    and-int/lit16 v0, v1, 0xf0

    const/16 v2, 0xe0

    if-ne v0, v2, :cond_5

    .line 114
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v0

    .line 115
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v2

    and-int/lit8 v1, v1, 0xf

    shl-int/lit8 v1, v1, 0xc

    shl-int/lit8 v0, v0, 0x6

    or-int/2addr v0, v1

    or-int/2addr v0, v2

    const/16 v1, 0x800

    if-lt v0, v1, :cond_4

    .line 118
    invoke-static {v0}, Lio/socket/utf8/UTF8;->checkScalarValue(I)V

    return v0

    .line 121
    :cond_4
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    invoke-direct {v0, v3}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_5
    and-int/lit16 v0, v1, 0xf8

    const/16 v2, 0xf0

    if-ne v0, v2, :cond_6

    .line 126
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v0

    .line 127
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v2

    .line 128
    invoke-static {}, Lio/socket/utf8/UTF8;->readContinuationByte()I

    move-result v4

    and-int/lit8 v1, v1, 0xf

    shl-int/lit8 v1, v1, 0x12

    shl-int/lit8 v0, v0, 0xc

    or-int/2addr v0, v1

    shl-int/lit8 v1, v2, 0x6

    or-int/2addr v0, v1

    or-int/2addr v0, v4

    const/high16 v1, 0x10000

    if-lt v0, v1, :cond_6

    const v1, 0x10ffff

    if-gt v0, v1, :cond_6

    return v0

    .line 135
    :cond_6
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    invoke-direct {v0, v3}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 89
    :cond_7
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    const-string v1, "Invalid byte index"

    invoke-direct {v0, v1}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static encode(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .line 21
    invoke-static {p0}, Lio/socket/utf8/UTF8;->ucs2decode(Ljava/lang/String;)[I

    move-result-object p0

    .line 22
    array-length v0, p0

    .line 25
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, -0x1

    :goto_0
    add-int/lit8 v2, v2, 0x1

    if-ge v2, v0, :cond_0

    .line 27
    aget v3, p0, v2

    .line 28
    invoke-static {v3}, Lio/socket/utf8/UTF8;->encodeCodePoint(I)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 30
    :cond_0
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static encodeCodePoint(I)Ljava/lang/String;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .line 58
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    and-int/lit8 v1, p0, -0x80

    if-nez v1, :cond_0

    .line 60
    invoke-static {p0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    and-int/lit16 v1, p0, -0x800

    if-nez v1, :cond_1

    shr-int/lit8 v1, p0, 0x6

    and-int/lit8 v1, v1, 0x1f

    or-int/lit16 v1, v1, 0xc0

    .line 63
    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_1
    const/high16 v1, -0x10000

    and-int/2addr v1, p0

    const/4 v2, 0x6

    if-nez v1, :cond_2

    .line 65
    invoke-static {p0}, Lio/socket/utf8/UTF8;->checkScalarValue(I)V

    shr-int/lit8 v1, p0, 0xc

    and-int/lit8 v1, v1, 0xf

    or-int/lit16 v1, v1, 0xe0

    .line 66
    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 67
    invoke-static {p0, v2}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    goto :goto_0

    :cond_2
    const/high16 v1, -0x200000

    and-int/2addr v1, p0

    if-nez v1, :cond_3

    shr-int/lit8 v1, p0, 0x12

    and-int/lit8 v1, v1, 0x7

    or-int/lit16 v1, v1, 0xf0

    .line 69
    invoke-static {v1}, Ljava/lang/Character;->toChars(I)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    const/16 v1, 0xc

    .line 70
    invoke-static {p0, v1}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 71
    invoke-static {p0, v2}, Lio/socket/utf8/UTF8;->createByte(II)[C

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    :cond_3
    :goto_0
    and-int/lit8 p0, p0, 0x3f

    or-int/lit16 p0, p0, 0x80

    .line 73
    invoke-static {p0}, Ljava/lang/Character;->toChars(I)[C

    move-result-object p0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append([C)Ljava/lang/StringBuilder;

    .line 74
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static listToArray(Ljava/util/List;)[I
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Ljava/lang/Integer;",
            ">;)[I"
        }
    .end annotation

    .line 171
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v0

    .line 172
    new-array v1, v0, [I

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v0, :cond_0

    .line 174
    invoke-interface {p0, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    aput v3, v1, v2

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_0
    return-object v1
.end method

.method private static readContinuationByte()I
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lio/socket/utf8/UTF8Exception;
        }
    .end annotation

    .line 139
    sget v0, Lio/socket/utf8/UTF8;->byteIndex:I

    sget v1, Lio/socket/utf8/UTF8;->byteCount:I

    if-ge v0, v1, :cond_1

    .line 143
    sget-object v1, Lio/socket/utf8/UTF8;->byteArray:[I

    aget v1, v1, v0

    and-int/lit16 v1, v1, 0xff

    add-int/lit8 v0, v0, 0x1

    .line 144
    sput v0, Lio/socket/utf8/UTF8;->byteIndex:I

    and-int/lit16 v0, v1, 0xc0

    const/16 v2, 0x80

    if-ne v0, v2, :cond_0

    and-int/lit8 v0, v1, 0x3f

    return v0

    .line 150
    :cond_0
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    const-string v1, "Invalid continuation byte"

    invoke-direct {v0, v1}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 140
    :cond_1
    new-instance v0, Lio/socket/utf8/UTF8Exception;

    const-string v1, "Invalid byte index"

    invoke-direct {v0, v1}, Lio/socket/utf8/UTF8Exception;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static ucs2decode(Ljava/lang/String;)[I
    .locals 6

    .line 46
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    const/4 v1, 0x0

    .line 47
    invoke-virtual {p0, v1, v0}, Ljava/lang/String;->codePointCount(II)I

    move-result v2

    new-array v2, v2, [I

    const/4 v3, 0x0

    :goto_0
    if-ge v1, v0, :cond_0

    .line 51
    invoke-virtual {p0, v1}, Ljava/lang/String;->codePointAt(I)I

    move-result v4

    add-int/lit8 v5, v3, 0x1

    .line 52
    aput v4, v2, v3

    .line 50
    invoke-static {v4}, Ljava/lang/Character;->charCount(I)I

    move-result v3

    add-int/2addr v1, v3

    move v3, v5

    goto :goto_0

    :cond_0
    return-object v2
.end method

.method private static ucs2encode([I)Ljava/lang/String;
    .locals 4

    .line 154
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 155
    array-length v1, p0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget v3, p0, v2

    .line 156
    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->appendCodePoint(I)Ljava/lang/StringBuilder;

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 158
    :cond_0
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method
