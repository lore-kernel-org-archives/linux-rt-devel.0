Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090241D86F2
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361558; cv=none; b=K6HUI7/fUIeN9UkoX8fKVKl8I6j9vHPKhcEpxOvhmKech9Vifq2i4m2mtb+VioV1K8qyYYAKtjhszAAWypqFv7/3yAi9nF85QfRaN4hE9uPfHYUgYLL67DlHDzbaI6Ha82MZ/CXa4mM0GJ0Ws0hz993zaQHJUSyD//ozBEBz/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361558; c=relaxed/simple;
	bh=JPt+xC4eyv+WQHyNcmq0S8J7JpIxDT7l8ZQI8yLkBps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQFFYv9ttatssVJSGacM7JsbM8T6WRe5KrO/5XBiBbz63pIIwmZB3JfCgn0R3/UCWiytAzsJ6Lvng1yKGKMj0ulBEMIjJ2UOO0doNoYYsmOoqTZcEDq928vVNPcNhnNfGtezBxzRzvFD48ESIGg2zVg6R0/pGU76KtJ6teCCbUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR+GfAU8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR+GfAU8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38dd2f309deso243598f8f.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 03:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739361555; x=1739966355; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eSl5YfX4v8OgkeO1jdSOmTgQstGlkukMTg9/pwP0Ps=;
        b=gR+GfAU84LOeuWQGBJi8p+i6dZ0sWhGb1pFsb26zU3tryczLDpP3WAsZMWAe6+azit
         SAzsdvCHlWZYcIuKO+OoeyUHUmERiWIPlvOyz0bW1VPSKUDSHoO/f2WPYzEVDaQkj9xv
         ys1hWMsUmwx8BHa74+WKksVzp5PyTP+3LObHux6Tm1/mlNL+ganTO+MIzBpn7JcrPxln
         tiYnFyWvdBw/nYgY0u2AZld5yPyzp/m3vDdznpcwzOb7WMrVPTZmQNx5uo+yJNVrsfY6
         jTc8VkTlpIhrPc/AJTAn4TlJBfg/u5nXXmNdVxW9kqCh5PmdQ4KzdD4Fd2zxn5ol6/9W
         u0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739361555; x=1739966355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eSl5YfX4v8OgkeO1jdSOmTgQstGlkukMTg9/pwP0Ps=;
        b=GnUm9bLsYK4so5TaIHz81+CfeP/wuRe53g89mQIy9NRJVkh1TILrbu0YwldYvJF13c
         EDEubx7yDf6JXJ75uw0X3A+W0r0RFo8RB8XVoyCZwS5dG4mtwBepNZVDFo2BqxYjsO2I
         ap9rQCk9h8vWvFBvKos5C+a/P4xUY3Ye1un5ycJSjSGhj/tN2iE8k7qTowYAn50LN/JL
         MG6oHfyQFtSPp8hNKYKSJ5NWb7eRnInRj1hT7WmD6RdPIRwgtNwKOPWFP1dKIVYbBkC/
         2t5EzQ77Pd3/aBodjrPcEth9z8UW2lASCYKCOnYa8kx9+KtFnViH0b2NzZ9fomKkFNPN
         GC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUwAV0BKZsCjB/QUTk8SjrhiCuOs68xva5gmqeCAPBaf0hgh8YZg+fPLFtiFcCG5eFBi05BpAEd96mOUbybGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVmntXFB7ZUwGsCDT7NX7RlxgsDqVS5DnHeR8+ourT/Xrj4LY0
	TYMwc9brl7V4qUUAruYoZ7Fv27meVDe/rtiXykVdXKMS22a6iHWL9Ae3X70ecOxU26ZRfkAvd1T
	QaBzGOXcDiHPDU71Afdz4kG3id7Q=
X-Gm-Gg: ASbGncte/soLtCZQQGapB5dsSPr3LrAcyv3qwNffbgTvrc/eqO1i1pJhKW/MDeADHyK
	cMbkNSYNK7yNgejs2ykZIxqSLMmNVwgDj3dV+1zCHwQ0XUZ/XnhjgyT3WXwyft2s3+dvxg2RKhR
	WCg+BPq9/dlT0TRc3Pw2EUgZW2aHo=
X-Google-Smtp-Source: AGHT+IG3fmHz2E+6aMtRT6NZtv0M4VNelZBA1J0TIg1co0vQFmeR6ifavyyfyKBLbGkyrmm4MYHT38YxPlA2+orv6kk=
X-Received: by 2002:a5d:64e4:0:b0:38d:be5e:b2a7 with SMTP id
 ffacd0b85a97d-38dea2e98e7mr967564f8f.10.1739361555145; Wed, 12 Feb 2025
 03:59:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250211160750.1301353-1-longman@redhat.com>
In-Reply-To: <20250211160750.1301353-1-longman@redhat.com>
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Date: Wed, 12 Feb 2025 12:59:01 +0100
X-Gm-Features: AWEUYZnaqmNFQ_lbBc6EZt7NZdSpHvlmvNFB56VaHucCrwmsBCcCq_pnMuQNjtc
Message-ID: <CAPAsAGzk4h3B-LNQdedrk=2aRbPoOJeVv_tQF2QPgzwwUvirEw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Waiman Long <longman@redhat.com>
Cc: Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 5:08=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 3fe77a360f1c..e1ee687966aa 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -398,9 +398,20 @@ static void print_address_description(void *addr, u8=
 tag,
>                 pr_err("\n");
>         }
>
> -       if (is_vmalloc_addr(addr)) {
> -               struct vm_struct *va =3D find_vm_area(addr);
> +       if (!is_vmalloc_addr(addr))
> +               goto print_page;
>
> +       /*
> +        * RT kernel cannot call find_vm_area() in atomic context.
> +        * For !RT kernel, prevent spinlock_t inside raw_spinlock_t warni=
ng
> +        * by raising wait-type to WAIT_SLEEP.
> +        */
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEE=
P);
> +               struct vm_struct *va;
> +
> +               lock_map_acquire_try(&vmalloc_map);
> +               va =3D find_vm_area(addr);

Can we hide all this logic behind some function like
kasan_find_vm_area() which would return NULL for -rt?

>                 if (va) {
>                         pr_err("The buggy address belongs to the virtual =
mapping at\n"
>                                " [%px, %px) created by:\n"
> @@ -410,8 +421,13 @@ static void print_address_description(void *addr, u8=
 tag,
>
>                         page =3D vmalloc_to_page(addr);

Or does vmalloc_to_page() secretly take  some lock somewhere so we
need to guard it with this 'vmalloc_map' too?
So my suggestion above wouldn't be enough, if that's the case.

>                 }
> +               lock_map_release(&vmalloc_map);
> +       } else {
> +               pr_err("The buggy address %px belongs to a vmalloc virtua=
l mapping\n",
> +                       addr);
>         }
>
