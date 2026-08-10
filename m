Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4CF3D9DD1
	for <linux-rt-devel@lists.linux.dev>; Mon, 10 Aug 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365976; cv=pass; b=FTafQZoQFqPlpqFs6CV4HVTXiywdpi0SOIYBMd86+hXBJ8UMtam47vXYp7UrLCkMPQ0ncafDfJcTR+KlFaRNXb3pMYVgFD9j7su0ClKZvWP1TCjzNJA5LBd+EVvRUYmjjxczky2S7Xu/PVZ88A2f+/K8Ginls4qJ8xtzGpPvmkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365976; c=relaxed/simple;
	bh=fC5scpO7qB1WJtBVuvM5ZMx/R6ROE9ZcFEteFfw1clQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkQjN1YzC9QqviWytRgb4IJVVaf6NfsDHk6gT9YEHhcMdjfQX1X6E87oibi4GUJ9j6jExp9pE8LJDQssjDclMQMB+8OsbneQFpKcv+0yeQK5mdRI31UpNVOGLEg8UdGLU2wd8QQwiNVk2hZkvxdHELL1YiCzf5xJdMZKPHtFvfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7DnEv0x; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7DnEv0x"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so2785405a12.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 10 Aug 2026 05:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786365973; cv=none;
        d=google.com; s=arc-20260327;
        b=hbKp45p3Jr3YSOftMcHNQO5jSrL/R1Nhk2EeeErV8uoZmJ2a8ugFe0mARMD2J+kWde
         l1EDrKV3y9auQNAyATxHZBhVKfQx8uK+9AqQwq6PAnD66ujzorlFcxohDAwc2JJJvUvx
         N0INoASwCiDjGm930uMUZC8V2xzWqfL5CknVgdSOM8bkjAQA7VitPV7wtgG7vM1GsU3l
         iwg+yKBsNw9aaGhSUHeQBpKRMoJ7BLlGYWzkj+wnQothZyb5XQuCTUbx99SNYZ1a6jkG
         UqDEVTMALxT/ybZEQKcLJ0Q9dbU69SItlaOzUtnv+wrKyrLixuEERwPMccTQZao4bknA
         c/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        fh=XE3/Eyt2h3v5PvPgoeRNbf5vJNt48U44xX2a6nluJjA=;
        b=C7yuCczkCr/ft2i74v95gshIyfIyTUKptQjDI+kjOK1V8tLvhbGyuX94z/3e1uWDk1
         UgjTNGwI6tSgsxzbq7m1XD9HbKz6V7h3mEW+0QbYHWnJdpauvOyw2m/dIcoEaHCG+B4f
         aIeB+xEjw8JAChaZ8R3SKL47rGprw71IRfrAJSQqKYLl4lA33gzX5ZtvsHtUIUZeT0mK
         aXuVj1nf0PijcUIldsqWkvfpFYF4XT5uT2Fqaqp2xAqu22RmukQ0XP6vMHqLbK6ahzGF
         wrTiHcVnnD7u4Q1iac4fFr2t7DlJlOErwnqWSOFiU+jpKG2LLjv1/qrArcTdnGfhLqtZ
         CMhg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786365973; x=1786970773; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        b=V7DnEv0xPiWbz3H/+iKUpyCBFfu9LiPMWDLjpVkiRZ+Pyb/3Y7fl+MDFqr4i687NP2
         dqTXSIjRItLLa0pkH32h0CoHr8pezCVtv2LRPXeGoaGBJBI6EGECiNPGdg8rDTtsM843
         wPa6fVd3wSeTefbqi2a58k3ZpOH4cToRpiEubxbInzPGNNam68xhdv8/IkLOHHIb+w/T
         dyv4IY7SExc0GO2779yHeO/BqgXP4npH+R5JTG0DNTWdeTqX1lIfaOMOSftSSUyQI7JT
         yiyoczDffuoVAvQ9kr2vpo80nUIDb0/xCQaDd17x4DnvM7XPjAit/swXnk4DtT0jmq67
         petQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786365973; x=1786970773;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsow79yVgjfnSj31xvsO1YjaEkdqg7wriMmgcGrZl6Q=;
        b=j6FqdwpSbYNcWJUdN4VR0fETcDRdcBdMOXrIAv5MtIjkWdujtMTFngBZKWem9TElvJ
         oid2xbaYnJcv228oZNDqb64BYzSJhSHMYsKhF1iBV6SfUzvGb5LUezlN/fHfv+2t/8/O
         WfK3GXtPpSDGLuqMZkbZv2QYJKoLRUDalEN+zImSuaVzRK4fA9zkQz8QOssRvQ8shKQ9
         SufSq5aMw6AI9NTjZipf7cFb6HCpWGZlVtqNqG7ej3i0bamlJ/0H52whw8BXwrS2Sy28
         JkBIuZNCe/HI30QyFSb2OoBA/2Fk7tdrB/lI25m7HSFHfsxo+8KN02oxrCWU1CAn2uAm
         nKVA==
X-Forwarded-Encrypted: i=1; AHgh+RpY6p8W7YgJdBnIAcqfkusZ6iJGylESPm+3IvA/dx1DCYZB13CiZFsBcUKepuUxk5yn296j1NZpdgj5CPTOcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT4cctfWY1LUwlBpaGvh/W++8kdt8k0dDn1BJMU+fNUF3FIfWt
	INAGZpNu6qU9cARiXG/URsB23iAezPYhBTYaMUllMv40x+0lWRslf57qQ5asuFi9spy4X/iVwKT
	DblrWKXVdvwMH11sz/OK64zRQrgdR89Y=
X-Gm-Gg: AR+sD130OJ5Suu1NBxTi2FhALCK4NSZIOaoxH41njcAoR+NXM5sRBIcvpDvXMMWpUbY
	jtMiA4FT/XGj5ve8vV+UwYY4VTClXHpgoNs13TzJeTQKjSKPXALwQCP4IfjBVQmygKta9baxl4l
	j8iY7EnmGw3be7sUMllQX3Q9hxhFAuvRK+P2qak8sZhf+RqG18Ii+GMNHl0zC1Q/Et+sB+ht0f4
	g5CCOXtqo/VuqYki1MTliYbwXgmc6nCALAhTRpvsNmyeINDKmae9CLhHRbSZ7gnLBf6u4EE+I1I
	VLp6bduGPWTBNXObntJJahK7A5XKPpvtNXhqbfGyohX9wOgZU19puFgA+GE3
X-Received: by 2002:a17:906:fe46:b0:c20:1ec5:feb8 with SMTP id
 a640c23a62f3a-c20c6a09bccmr70511066b.29.1786365973030; Mon, 10 Aug 2026
 05:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260810122758.183765-1-puranjay@kernel.org> <20260810122758.183765-3-puranjay@kernel.org>
 <20260810124300.6F6F61F000E9@smtp.kernel.org>
In-Reply-To: <20260810124300.6F6F61F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 10 Aug 2026 13:45:58 +0100
X-Gm-Features: AUfX_my7sbKVXUQi_BH5L2H9-539lpsxcbJXElUuAGQoqY3CI2Fhbga_HcDN4KA
Message-ID: <CANk7y0gXovcHspdT9T3SRdnW5_R5z3-25G+CJnHTD3UPPFSLRw@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 1:43=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Moving `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypasses=
 debugobjects tracking for deferred RCU callbacks, masking use-after-free b=
ugs and causing list corruption on double frees.
> --
>
> --- Patch [2]: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from=
 any context ---
> commit b9d1d9e1aa870c19c3d9b30019cdb1bc509b6703
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> rcu: Make Tiny call_rcu() safe to call from any context
>
> This commit updates Tiny call_rcu() to handle interrupts-disabled context=
s
> when the scheduler is active. It defers the callback on a lockless list
> which is re-issued later via an irq_work, similar to Tree RCU.
>
> > diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> > index dccccd6be9411..656b6a682e31a 100644
> > --- a/kernel/rcu/tiny.c
> > +++ b/kernel/rcu/tiny.c
> [ ... ]
> > @@ -157,29 +251,19 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
> >   */
> >  void call_rcu(struct rcu_head *head, rcu_callback_t func)
> >  {
> > -     static atomic_t doublefrees;
> > -     unsigned long flags;
> > -
> > -     if (debug_rcu_head_queue(head)) {
> > -             if (atomic_inc_return(&doublefrees) < 4) {
> > -                     pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __=
func__, head, head->func);
> > -                     mem_dump_obj(head);
> > -             }
> > +     if (should_rcu_defer()) {
> > +             call_rcu_defer(head, func);
> >               return;
> >       }
>
> [Severity: High]
> Does moving debug_rcu_head_queue() into rcu_do_enqueue() bypass debugobje=
cts
> tracking for deferred RCU callbacks?
>
> Execution is routed to call_rcu_defer() before debug_rcu_head_queue() can
> activate the object in the debugobjects tracker. Adding to the lockless l=
ist
> in call_rcu_defer() overwrites head->next without verifying if the RCU he=
ad
> is already enqueued.
>
> If a caller erroneously frees the object or double-queues it during the
> deferral window before the timer tick issues the irq_work drain, could th=
is
> mask use-after-free bugs or create cyclic structures on double frees?

double calling call_rcu() is already a BUG and doing it from NMI is
one level more. debug_rcu_head_queue() can't be called from NMI, until
we have something that can work from NMI we have to go with the
current implementation.
