Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51338756B
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121695; cv=pass; b=n7NiRi7aCXI2xqOOT1uINSrbToqvBoE+ucwB9cTVIJ0ckm/FRWTpRDx7PDUwHzBgu3ssPOdtTWgssfyp6EKWLgkWvhafXKXq+tOZv1ITYYD6DifbYErbILUfLYDfjVZYTaEQ1X++M207ZSglLb4i8xiaTKGAQ6E4JG9phVix0To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121695; c=relaxed/simple;
	bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrL7n5w7EQ7T6EBZoEnDtCYAlMfQ9uOcAqVmycGSNHTyPZcDvFdL64vgixPy38M8aysdbG7zRQXTHT9bVC32ycOuNlmDMy8gqr5/7hlR9dsm4a4H6mKy8wlb7rLK9NCBenIooOm488G1X8tA737RikoGrcYBoGLtVK4tdkAqzKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XGKtvz9E; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XGKtvz9E"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4888375f735so5091625e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Apr 2026 02:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775121691; cv=none;
        d=google.com; s=arc-20240605;
        b=SUe4Biq4Jv+BKpSEOjq60Ao0B1XHnf9ydl3SLSoSKTrh/YAwcEWYwyq853Ad/92r5A
         FEG/uyV2HmW1+z/GMBxeX/okMgsrKWsE3O3xRJTGdP327Vm8g7+wstDpCKI/A3wWCAY/
         F7jVHDuJK3yj9lmoc76b7uBOBwCPutGf8eU8KMYX42HoXmKu3WR9f4mdJriUUvcl4uBs
         0gAict9EC3bPgacB7Uaq7AoHhwWj0Oi1Vo5cER1wcg2s0dkqCbaWilu0QfG4Ke7LviJA
         rsL1YykaDzSeqCbI8L3PCqnOtDpey95poicRY+e1PlwdSF9miRUnKtE0J/du9qXz11nP
         Jqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        fh=f9u4Niavk4ACLg7DTZC/G9aZVMtLWtOKkmWspVDqe0k=;
        b=a7GlgcAUvbsjtxFIa+IX7oWByD37yCxDeSysZzPqXS3ABQb0A/VvSAKHeNrxGV201H
         yDU0yEpir9VPBwo/WVJ8285V0PKbbnvQw1j8WDJ32uAE0YEiKnEzhVNoZI8YE+zJVpos
         6endUJ95Is++TbqcT11N91ddjg9UjJJMWX0ywMsYsqfrC2jo8kKJuNVCeehNd69dNMRb
         SqNC6WI8u3dBUWmt3/gs862u8zfGZhaxLWBI5JjHZE1gbevcRYV9NLOJ7HbzxLDd8UBJ
         SUjG08KFPBtnPLjAOkSluD6RA+oUIQlgs8K3vTljtCjSJ4p87DPUSdenbNGQrhhZaG49
         ipzw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775121691; x=1775726491; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        b=XGKtvz9EMs3evv+efBDOF+a6XNvJlpxENB2bUEOqXFIvpzvJ40RAkp+xBEcnKcRx9V
         wSNi0gYXXbTzb9xuKmltMBipYgz5afKfqK1jJyMkGbheviwwTCOuFkZaOru++b+d4TOu
         j/iSQT1i8oVW9TlYPtNDcNE6Y3A7JG1/yGQAbAWcdfBPFLyIflX6+gZPUsZdQeECPCbM
         NnHCER3vTc92JpWKx04Eavd/rttjHpUA3wxOM/QJC/5gudFpIU/cRWrygXVn1uKMPJoR
         2lU42Es9uukrn0cJHi3ojN9gETLPlAloqxKza3vmSNKKly+7Mdy5Sqm+fa1YvDRaa/GU
         8mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121691; x=1775726491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        b=GFJf470z+FCltm47V9jIhp6uArkJGkBNOZOo/8Vqzq7LlHlR2DXjZSPzsWafw8KJEp
         XVCTtj2Amm6QkOmqH0fb+sDRPwYlO5PpdrgjWWqrDe930YOv/yYwJgAHDSX2rP65XQNN
         2sVpieywAoG5lYq7LgIjanMHtG+r26DSWxHHFopxKuqkv8iRGePxt1hnDK/KHYGTm11j
         j37cqLk9x/whCKQfHoLDjj8Y1AkGFfAstCZNA3NZraP4P79+JYgC/r7pF8t508JJfvOU
         hinMXWuoA5kNmhpu2ahnZ7KWPH0db0NaSUpg3A2dp14g9EUbXRGP8ZyDKDaaWm5UTojF
         b5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqP5XrzkyeJM2siH3/WScvVwIsQzoU6NqEQzCDua7tCXlG75a9j6OwY37FGG9yLp2lYiM0ZmrbZJHJFQ4fA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9c5356CrtxTbTrbXjngLAUfxJccWO06mSUnYr0xIJ3kjllfK/
	/n2k6uuv1wgAuhFpb8SM5/4Dvnx5XbYQffao6HRUiNGJAdkQ1LDzuWQw/82PLehiFhWMS0va/+/
	EmKbpEwTrPg8r9cPc4LeIyd8JuoW6U4qc4M8X71SpZg==
X-Gm-Gg: ATEYQzz8nLhyqXJKxeU2KtJtR6VzPsX8ntPaPtCOxhlDVN3BMIzo367Xd5g9XrCjaHk
	Qf9ufAaMl2jhM69uwvKWzRKMFqN2/GXCnnIUayFQHIj+sqiTWHEgJGUm5VMSs4kBjMRUSSULr/S
	jJ/3+NKqFoORcVohCsrbQuKYzu+K6FiRYZssXtZykd12KPwOsdQTEhWkX5LGI/T/fx1/F2i9r80
	grwGamkJNbCNxURdshrQwJmkAHQv2krtQ1tuCR4L6dCoumrksi6/0SKrDdOj5nsfnxh85fKKqYr
	gLxxfdZB0GT3Wp5UiJuilXm0rJWndXUQR1WK25tE6zCUWPZc+XNUhsmbP6wb6ihdPKC6pjVAEL+
	faW1Y
X-Received: by 2002:a05:600c:354d:b0:487:386:3714 with SMTP id
 5b1f17b1804b1-48883597e29mr110144355e9.17.1775121691116; Thu, 02 Apr 2026
 02:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260218073036.AlkNRoAP@linutronix.de> <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de> <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de> <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de> <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
 <20260402083123.1H4kyAEn@linutronix.de>
In-Reply-To: <20260402083123.1H4kyAEn@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 11:21:20 +0200
X-Gm-Features: AQROBzChG2baadjgz8ltJV9SHGvnYSyy-pP9io372jEf1uyHe9Xp8DZ8CmmjL-I
Message-ID: <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Apr 2026 at 10:31, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-02 09:50:35 [+0200], Daniel Vacek wrote:
> > My idea was that the non-preemptible one can record `current` task
> > instead of the CPU to detect the deadlock. And that would also work
> > for the preemptible case (it would actually match the lock owner
> > approach as you did for the PREEMPT_RT case).
> > One code for both configurations, no special-casing. I'd argue that's
> > a better result. Am I missing something?
> >
> > The size of the netdev_queue structure would grow by 8 bytes for !RT
> > case, but that's not a big deal, IMO. For RT case it would just fill
> > the hole.
>
> We have xmit_lock_owner as int. If you replace it with task_struct *
> then on 64bit the size of the struct netdev_queue will remain unchanged
> as it fills the hole before the following long.
> Then you could record `current' as the lock owner in both cases. This
> should work.

Well, that's the patch I originally sent then.

https://lore.kernel.org/linux-rt-devel/20260318103009.2120920-1-neelx@suse.com/

--nX

>
> Sebastian
