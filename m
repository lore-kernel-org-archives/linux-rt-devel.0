Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA4257AC8
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151410; cv=none; b=ervxw/Tgnn9gDinb9Mpz18KolPYLq9Z+1Um01mmQuCVUMi/C4DPdJqCpmHgupxiQqRkXOoCbt01aQH2MQTOnzaYz6Pyz2pA5EVouMja/bLfbp3gUnOMYHs87jj/LTXUGHeh/pcQ1NWykNshtLoKCTvrkEn1HwhdImXWXYTll3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151410; c=relaxed/simple;
	bh=s6KFsIWe08m+NRGKyxGg6ZnduWNzBb00Sh/FpcugVHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBRXXe0BYvdkQR9U8IriK4NcU7sarPxBs9L/8JQt0qFDUds9HOslIKc7xb3uqLEGZuqFfv2wsaTKdKwY+XfmSns4h/aQJ76vcPmHe9zx4M2A1WU5+WvWArGYPfbHrPiJBXHBBGUR8O0kfIdVJY59N/RP1zDrzEUmosY9qtIWEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJK6rDt5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJK6rDt5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54700a463so553223f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752151407; x=1752756207; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLZ3wT/zIcTlhpVZ66G+GThU9XAAh1rTUV/NBZEfAJw=;
        b=kJK6rDt5W2NSV/xBCtSnVCkDdWqbS3WxkKYfPOeKPhAtj+vH/4be1/0EJAca2uFIji
         GquZu5xHlRxR+69bG6FxzDHFdh3QERwonnQRVNzYUJP4dEFGMg0LAqEjAb/I1rtgJ1Di
         4TPwKfopy2VXkHyK0j3xWtyZ3pIXi+8B9hLBgTBUzSqV9/+oM2mE6YlyWWzMdwjsB2dm
         m0ZRLkjNDHkkV9z3dKw2CSrNiuml/08tYa1nuXTUfxPRZEPzQseXRYoa3uKQhGalz+lo
         G2dxiYxMKX3vUNxf9bl21reoeIgMLp50mZiclSj4w2rV40O43QpZF4Cp3P8ju7D906hy
         dCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151407; x=1752756207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLZ3wT/zIcTlhpVZ66G+GThU9XAAh1rTUV/NBZEfAJw=;
        b=iG4EyagtudhinNEuVnxu7ToRu0eTISMjcgdJ9oYhLJGW3N2UZGVFYbPgZ23+SquVJB
         QDvtq2kzbSGBN/xjAvO5yQ15M5umLsBKsIc0upuckm159B/2rMvTcRBV47xZwMxsiAkr
         sg5zSjV08ULNHCP1VOB/VaARqalHJ0UDy84w5KB3BeMzt3lIWoBAidm3ncfcv+Hwayc+
         nxufGqMKldceSxVc6E5Oegx6zgw5wVhagfauUXTA4d95mKlBBubtzmV6k3Yf+iH3g5o3
         kUxxCDZO6jjk7vUlAgoxMnF3bRk72sRjy9sNCWjB9dk1BXoftnliZfrwT7exPgUI+va5
         BKLg==
X-Forwarded-Encrypted: i=1; AJvYcCU3CLF4caOAc6lL2SkuLXTuYfkF2DfONTD5rwAxDsUd/FvNNpNg/jkOb4oEfeEQCid4loOf6IEKIxJ+50RO+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbNknTnMoW/nb+IA+fb5sSC1heF21swxntkFWwn7KmAHZEMoD7
	rzuhox+rSAhn/SdFwPeeZL83thia95tmUInSVUv/9eaBeQicD0yvk9C0BO438fOtWJ5bW2NVh9A
	uzTz/vWetvW3wozahfGXNDiuOgmEAWR4=
X-Gm-Gg: ASbGnctns0ZyBTmOg94l22Ark43Q9rUYUmoyEtDajCBAtb1xiP1vAzGHNeraEt9Spb7
	vKpo2u4b+jUfX5aT0CkHLyeeq6tQrEC7nNkuMzCbUFpwDcRVDFcVwgG2a8psdRcpXICGe5DO7zZ
	ccQ+0lvT2N9QMtioVN9qWQF3WSyXIy86/exjzHhcMmEKPhhg==
X-Google-Smtp-Source: AGHT+IEnLv+M1cm1e41yBczHzCqcGvBz2LxWly+f89XFFbMNN8WbM3UxVWoFEfEmHMVnnkn6nxf6P78yVudOGfXKEXQ=
X-Received: by 2002:a05:6000:22c3:b0:3b5:e07f:9442 with SMTP id
 ffacd0b85a97d-3b5e7f34672mr2613771f8f.19.1752151406804; Thu, 10 Jul 2025
 05:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 10 Jul 2025 14:43:15 +0200
X-Gm-Features: Ac12FXxkeNT4SbQnhPymL-kgefhQmsJ3o4VsRU7W2osYTS5GaGgeUo2hYTeE0yw
Message-ID: <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	byungchul@sk.com, max.byungchul.park@gmail.com, ysk@kzalloc.com, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:10=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> wr=
ote:
>
> find_vm_area() couldn't be called in atomic_context.
> If find_vm_area() is called to reports vm area information,
> kasan can trigger deadlock like:
>
> CPU0                                CPU1
> vmalloc();
>  alloc_vmap_area();
>   spin_lock(&vn->busy.lock)
>                                     spin_lock_bh(&some_lock);
>    <interrupt occurs>
>    <in softirq>
>    spin_lock(&some_lock);
>                                     <access invalid address>
>                                     kasan_report();
>                                      print_report();
>                                       print_address_description();
>                                        kasan_find_vm_area();
>                                         find_vm_area();
>                                          spin_lock(&vn->busy.lock) // dea=
dlock!
>
> To prevent possible deadlock while kasan reports, remove kasan_find_vm_ar=
ea().
>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Reported-by: Yunseong Kim <ysk@kzalloc.com>
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>

As a fix:

Acked-by: Andrey Konovalov <andreyknvl@gmail.com>

But it would be great to figure out a way to eventually restore this
functionality; I'll file a bug for this once this patch lands. The
virtual mapping info helps with real issues: e.g. just recently it
helped me to quickly see the issue that caused a false-positive report
[1].

[1] https://lore.kernel.org/all/CA+fCnZfzHOFjVo43UZK8H6h3j=3DOHjfF13oFJvT0P=
-SM84Oc4qQ@mail.gmail.com/
