Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5AD36DA18
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950221; cv=pass; b=XLRvu0Czri+zeuWig27iyoXcR51MC6JnMViKIctwEWNa284HnESNsF2PsBUugq0FX0PIaROtjDuG9m3fuD2T+v+IWF7D709F4g+7CC4kMzrjc3F0zYp0qmoHgkvqNdWgJQGxwbmM/8beYsSW63TT/yCu92Z/kq9huVPGqsa3kwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950221; c=relaxed/simple;
	bh=VCTTpD8pvxJ1f7angD6R6tXvCBNfl8EVF0KiF5vqwec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbAeCvsh0CvdVIo+swR0V4I1r2xJlXFghaYZ7/Wgzs8htbiyKjlJnVZKN56vJlCUPwRSB6kOhV4ioy1E1rpzavcZdSC6M4LWmch7XaNs1xzNphO9zKwOjeu3mYiwbR9gkee6RHzyNEZJT5wyiB0mwutf8JKOe8/LsJYPieBFX3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkDIIFul; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkDIIFul"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498012a61f6so11335e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 13:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787950218; cv=none;
        d=google.com; s=arc-20260327;
        b=n2TSboWjUzcNOMv6q0CFRO+4qtg0G0UJofoJCLgHHGD6FBl9yNiOVlhSfQE2/FMSlr
         sVuFGm1GGEVXAvKAB5HueVNzgt2sbaKstAzmClpagJ+3Y4tGjYYMZ+578y6mglizId7L
         dfIqcAcVXHf6W/wzTigDM5YLrXJuBWndDg/d9liP9XOYDUstQFE6qmqvHV1sOaW8pFay
         x1JbCFtPhCa49jfQ7AViAM/eAh6O5hR00S7824egVOiKubofADYqldQLiJv6tRPF+l/g
         OWCtpEUUUSkr9g3OfxzQdyuBShIhQZMqHFPrDyFV6swVxiYEBowLI7iarMuCJpRAxZ5Q
         zWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AshsUhDS0njxXs9dy2fBnY4fbd5Y93s1/0Sdvq7L85o=;
        fh=yNvlsQKNwcNEVFZdRVVk+7YY28HiRSp3j5jNtWHX1MU=;
        b=boTfUezfGtdutg8WEuDy8wYfvOwS08+VR0fJnLYWMSIad+a6OQQNLH7XziO7vbr1Cw
         7MeRRMrl3wSS4LcDcMDgRHj8tVk76WHRgYQ+LHsFUWPlizdyeEjFIOPr70no8Ux0EgEu
         sqdmqpcSontn0f2CzI4aBkk4phLBzD0o4xNA33O1jL/fBz+hw1MOplSkViLhDa0o7bP3
         T+NsMGMxS5HJyjZnPx0CyBuN0kbbeLe4sUBCdLlyGXctCT7A8HtHZEKqGDH7CcDzsXNW
         13LIIUHNe418PNaH6xtQShwY7uI9rnoCHGxC7EZyZ17SFFxVJhRiJE6ECiZTto79EB4U
         angg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787950218; x=1788555018; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AshsUhDS0njxXs9dy2fBnY4fbd5Y93s1/0Sdvq7L85o=;
        b=HkDIIFulFPmV6aGLvOvLSdNp2bsa6Q1iFUCCz+6rhFBni//r/i72HmC7l8rhZJbgcJ
         bXMur0cJl0T81d+5G23yuLxOLr3Y+tUzx0AW+1N+XRXahHum7bpasnui3+4c6xrMsuAn
         ltWLey/WOHcfu9bUjPU7EeTytUiD8PJOtvcCQcLxtqDD78PlPXgrhu0TngAm8Z4SA/DB
         3HXnaZ6F4dn5oRbEVUCp5EhiCZqajzhiUD/bqOUkcCtaGC/YjSx89Khpk7tarJ68Dct7
         K5KhSrueJTEflDajlrfd+SfqhuSoHbgxNOQ4qJtwYoejK+4Lm1elScuAFlVvbM0I5Qav
         Fo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950218; x=1788555018;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AshsUhDS0njxXs9dy2fBnY4fbd5Y93s1/0Sdvq7L85o=;
        b=B0QsX8Jk79C2HSSpSq6et0gt4UWZNhOsf4t5u80OKCJKNVPaBms3EnhfNzTiIJsdC1
         RFbC5vhoMH08M13P9s7/WBzg0NEcBe+/Duym/NT1ZAkvUads3q87kLM1/2Uy7thqAIye
         3LTJ3nl/ErIYHQIn1JVqiFswywZJ1D+g3n77PaTrJEp85WQDZ+4JlimLU3mZ1mPW/t+d
         NXye0vdp2BqxeYRZdkJo7ojc5fdeMwvmnAigrBSuQHjxlPuLpn4tNXhtlWYbdmNmR04m
         RXqmKpmGrishzk1cHatB+/AmaJySUValEe71p3r69BW+PA7vqAWiSBmf8f6Vjyy3a0IF
         9GLw==
X-Forwarded-Encrypted: i=1; AHgh+RpUXMcgMtyZNmx6zFxIi+K/ZKNLaqhlRCpX1WpVvI8Hjtb8ZwN9WEq33v7MTSnEawi8w6gHrRKO/ey0TARrXw==@lists.linux.dev
X-Gm-Message-State: AFuF++lmmsBDmwZia3URo6YAyuk2262xbcxgPIkZGaSmMT99KOQDM4mY
	SZ/loFXgdrCXxnnt/E45VCCoLWmct1rxEU6EsyJ7YRjLWG3O53JEEuimZyd3xMRgYAqsbfTcb92
	MA0zIvemE7U6X/RUTTFLGCP+qAMl/LH9UoaJ0qpFA
X-Gm-Gg: AR+sD10yTOu3efXBDgFFph9wz2IaFilgQqyvUh4k4uaR5oXGd2ASqZUNihdMuY2XrHJ
	eSj6uuQGz/1SIdhIPgCIr+zUP+jvZqGZ4HX374MPcsZM672R4OBFAxrjnkz+ozL75hpIke/WiTS
	Zm/m0xowbeCGOt98anGGOUe+EjQRyxZ6zHmZsvKlW0wHKZjz5p7LltKxzsfnF7BqD5EPSUyPzff
	TeZnvdIj+0QZ5UpV+M/4MKVRYtgAzom8n7hbg/8kyqU/ZEaW+iq2TFJyQG8CI7+2hpy0nDq7XGT
	ZjltXqZUZbWf+7wX00AaKwTbhEV5mTtBNKVRu+3oWhYcP87AgW7i1+ERC0lrQ3noXN/Qg8378gE
	=
X-Received: by 2002:a05:600c:e40b:b0:499:a6a5:a687 with SMTP id
 5b1f17b1804b1-49ccbab90e6mr277105e9.0.1787950217353; Fri, 28 Aug 2026
 13:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de> <20260828135947.GU776954@noisy.programming.kicks-ass.net>
In-Reply-To: <20260828135947.GU776954@noisy.programming.kicks-ass.net>
From: David Stevens <stevensd@google.com>
Date: Fri, 28 Aug 2026 13:50:05 -0700
X-Gm-Features: AcwNN1VyWJkmCojhn4y_J0QYwM3NKcFniOfDcwtOJUcQgsmCVgZZIDC5YzitEe0
Message-ID: <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:59=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, Aug 28, 2026 at 03:36:20PM +0200, Sebastian Andrzej Siewior wrote=
:
> > On 2026-08-27 16:29:44 [-0700], David Stevens wrote:
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index fa7507ac8e13..adb4a5957996 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -1534,6 +1534,24 @@ config VMAP_STACK
> > >       backing virtual mappings with real shadow memory, and KASAN_VMA=
LLOC
> > >       must be enabled.
> > >
> > > +config HAVE_ARCH_RECLAIMABLE_STACK
> > > +   def_bool n
> > > +
> > > +config RECLAIMABLE_STACK
> > > +   default !PREEMPT_RT && !PROC_KCORE
> >
> > This shouldn't default like this for RT. It either is useable or it is
> > not.
> >
> > > +   bool "Allow stacks of some blocked threads to be reclaimed"
> > > +   depends on VMAP_STACK && !STACK_GROWSUP
> > > +   depends on HAVE_ARCH_RECLAIMABLE_STACK
> > > +   depends on !DEBUG_STACK_USAGE
> > > +   depends on !KASAN_VMALLOC # TODO: add support for this
> > > +   depends on !DEBUG_KMEMLEAK # TODO: add support for this
> > > +   help
> > > +     Enable this to allow the unused portion of kernel stacks of mos=
t
> > > +     blocked tasks to be reclaimed.
> > > +
> > > +     The wakeup latency of tasks with reclaimed stacks may increase,
> > > +     especially while the system is under memory pressure.
> >
> > It says *may* increase and on RT it _definitely_ will increase since
> > there is a kworker involved not to mention the memory allocation itself=
.
> > Anyway. This either needs to stay away from PREEMPT_RT or find a way to
> > exclude at the very least mlock()ed tasks.
> > Did lockdep see this?
>
> It should have. They're taking spinlock inside raw_spinlock and lockdep
> should very much warn about that by default.

It does trylocks on spinlocks and local locks, inside of
alloc_pages_nolock_noprof(). Lockdep considers that safe.

On PREEMPT_RT, it is necessary to skip the call to
alloc_pages_nolock_noprof() from under pi_lock, since with that
configuration spin_trylock can end up needing to take pi_lock. But at
least on !PREEMPT_RT, there is no risk of deadlock.

-David
