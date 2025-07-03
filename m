Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1119A
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Jul 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569536; cv=none; b=jSjfJG1Do6+BjP90mGmc6+VeKIq1jjQCNzqwn04inJL5ipheOu+wbJ2tUAGMkrVrGwWsz3a7BGOug/C59qp6fUDXHfQAeWvYDvjkJF8PbOwcwKW8hDmgttIih9syGL6oNyZTLd6Q326QkfIUuwAW3YKtk+GJN1LvAJgfx+o/IYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569536; c=relaxed/simple;
	bh=4+MJjeW2hiM44MuofBy9Llynx1Jvq8BS3Q7t4UwhJ+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHJSHHscfDjoStxe1FLrsrzsoOCDQJOKw+9NQcAEcHGTtT5shQ9sYO8DQ+2Y7C+0HTOZJEVrB+bQAi7NIImQQgxzCWNCNKRuv0/N/7W/bordxTtQ8rl3FvpOMUFRO5KkjxFY4Cv5QZQhBbKOD3bN5gRZJrA5kPTVygDBCT5PTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biY3Y7jP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biY3Y7jP"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b45edf2303so123019f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Jul 2025 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751569533; x=1752174333; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEes5oE48jiUB+IbTjNoonD0N5PundEhMgfAv/RRt5A=;
        b=biY3Y7jPbx0cHJpIcVYrYkEQloDD2T/rZloEFWxepD3AKlETfg/mNe6K2dQKqI82a+
         yYCwlBzdrssqvrPe7a6Ay6hr4rSMOBt8ni3NpEC/j3UwlixK5Xq8LhlPM8w8hU8G/3k7
         XYm4eUmpe8PNmAzLoeSF09Iv0DKEAPmbK6+CjsTz4lzjMpoOFZPzMS+swYojAVHyQC/W
         d2fSNhoxy4GdVSi4izPYK1//6V0L758DNhGg1GakfJnCpmozQ3iQPdIxbjjodb//at2h
         u7W2fqpzwU9yh/5gzMx8i9ITK/JxQJaNuvZzG4jToldTLBjm40Lpi3oWE4eYaOGhZW/l
         siqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569533; x=1752174333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEes5oE48jiUB+IbTjNoonD0N5PundEhMgfAv/RRt5A=;
        b=J/XYlwrUkLVCmJcLKjrs3KO9ac6HL+I1kIdI9DoJdKd9pXrdp60RALyyTkubJ/jHID
         hsJVm49jMmCHWaAAiQlljp2vOIflp458sRG1ltPL0DE6Cpxp+pyI/ECVTkyNebFflLrk
         ZAxaX4r003yE00PbqmELkDSzguRxPyM7RfjARSi+p1nJ8IjtGeJcd2RmiR20KWeHbvx7
         DSAUVndmzHh0puT76yWwYOIAPFfOPyTCgTpgbt/0sDio32DRrBezAsvCXUuAUN1YVonl
         s8ilkzEpE4R8UoPbRv74Lf23/bBTLyhQvlfbfJleJuI4bcAe7bSAcc/UIJ2zDmuSnLDu
         qObA==
X-Forwarded-Encrypted: i=1; AJvYcCVQvTks30idPJNwFn8FBowKPlAfD19m0Fk2GErQM4pql8YpZ+T8Zmu4P4iVqg/+DDNWjlk3baS4gQ4Gp+3gKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpbgPWwwZhdOM5cPNR80afhYXwJH424/8o2SlDj4Ygq1zGQDzK
	bCM0G2y2c62UlCR3xubFuwweg/O3xseq62JoKkCIjLDX+2jdL6xmEAcWCbml4/v5altT5vJ6NSN
	fgCXIzw0sAofzRwjp6wfLv8i94e8PM0s=
X-Gm-Gg: ASbGncv7rqWi7VGMAijapXuyb2YpXudA0qMkzcQrzanX1EC6uHxBUB8Qj9TMjOK3dbe
	MSo9Kzoya/25WsUmgOvQROQ3miWo6s5c/bzgIKKNnEmYhH3+GDUW59C0EHQf2Rdtn7Ex/KG2nDG
	XuyrBjtd0bNa0dJJhsbhOc5DnxhdyKFu7jFrMVc0/VVu+j0Q==
X-Google-Smtp-Source: AGHT+IHm+VSOO90qj3mCUca2MtaNAmV7aZE1T8OrfB8NfoaCcGe/nTsW+Ix335J9Fw4FfhCKnToRFYqt56sVh1PC2zM=
X-Received: by 2002:a05:6000:401e:b0:3a6:f2a7:d0bb with SMTP id
 ffacd0b85a97d-3b1fd74c660mr6335061f8f.12.1751569531635; Thu, 03 Jul 2025
 12:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com> <CA+fCnZeL4KQJYg=yozG7Tr9JA=d+pMFHag_dkPUT=06khjz4xA@mail.gmail.com>
 <aGbSCG2B6464Lfz7@e129823.arm.com>
In-Reply-To: <aGbSCG2B6464Lfz7@e129823.arm.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 3 Jul 2025 21:05:20 +0200
X-Gm-Features: Ac12FXyxUbHA_lo-Kj6ls_i2v0Skaq2nx5J2PN_n_cVaHRgGx5xPMKN_AxPcMMo
Message-ID: <CA+fCnZfq570HfXpS1LLUVm0sHXW+rpkSOMLVzafZ2q_ogha47g@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, byungchul@sk.com, max.byungchul.park@gmail.com, 
	ysk@kzalloc.com, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:55=E2=80=AFPM Yeoreum Yun <yeoreum.yun@arm.com> wr=
ote:
>
> Hi Andrey,
>
> > >
> > > find_vm_area() couldn't be called in atomic_context.
> > > If find_vm_area() is called to reports vm area information,
> > > kasan can trigger deadlock like:
> > >
> > > CPU0                                CPU1
> > > vmalloc();
> > >  alloc_vmap_area();
> > >   spin_lock(&vn->busy.lock)
> > >                                     spin_lock_bh(&some_lock);
> > >    <interrupt occurs>
> > >    <in softirq>
> > >    spin_lock(&some_lock);
> > >                                     <access invalid address>
> > >                                     kasan_report();
> > >                                      print_report();
> > >                                       print_address_description();
> > >                                        kasan_find_vm_area();
> > >                                         find_vm_area();
> > >                                          spin_lock(&vn->busy.lock) //=
 deadlock!
> > >
> > > To prevent possible deadlock while kasan reports, remove kasan_find_v=
m_area().
> >
> > Can we keep it for when we are in_task()?
>
> We couldn't do. since when kasan_find_vm_area() is called,
> the report_lock is grabbed with irq disabled.
>
> Please check discuss with Andrey Ryabinin:
>   https://lore.kernel.org/all/4599f645-f79c-4cce-b686-494428bb9e2a@gmail.=
com/

That was about checking for !in_interrupt(), but I believe checking
for in_task() is different? But I'm not an expert on these checks.
