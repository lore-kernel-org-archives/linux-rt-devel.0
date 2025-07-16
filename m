Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6312B1ADC97
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Jul 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679768; cv=none; b=te2hdFOP0l3OtdW7Qjb+Zn16MmoeAa4sqkX0VebBEBpOCrUaQUJZ9Imqk736yJzaIwM8pO4HWbrT0dJVRtqvK68r+j5p4uo0dG2Ni22C/20mbo1qY7J3A3VRWz98bLfKm+4Uzyou/RCsxkYRRRtu7lOZuOM7So/AZbqQsoo8yo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679768; c=relaxed/simple;
	bh=WGE7sAM3OqMYV7DpWfNGBy5wnLne+qh8A6FOCqFFaUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0bgb1UvcPmuYJZdmEj9HLXCWIz2V5o254dAUPbn7I3cE8QR8MMzAxiH/1DrULd0NB1GwjXmNasHQhvIk9hkMOFRhJeJBkd2p+WhM+La3Nxuj2bTg4ObHDA5TKTw+FatBfJn3YEHSH2pQkNQWfkLom2mMvxoyynNe2gNfzKZ660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvqB0XGe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvqB0XGe"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso50319a91.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 16 Jul 2025 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752679767; x=1753284567; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DXRWy2GORatQ4WDqzRgN/A7GONpktQqNYMaPCTvZVp8=;
        b=CvqB0XGefZXx2Q9dqm9nSgkkEKlHLax8lKtMTPDdlJk+auQ4pM7Xr56JSONUAW+Bg5
         QNWzH7wBjbO3AqxPD3iK2qno3l7ePaChj4OiQo7W4ODiqAM9PWOoUTluKDNbAFi/i5pi
         zlJvxISZX7bnht0wo0vUoYpV7/M36JokNV63kJqlrWih5GR2grmADeuSirH1ov4teTFn
         PIopxD7fLXnvMl9QHEs4qYts12ubafUBe/E+rz/Fj7eROAZoFfU2/8Lf35F+1bMxiMUf
         K/h3/P8bjOamHp7aMuE/clZGasTUltRDPoBiMYFZkUGx48VMAelyB4O06AaaIUCRn2TA
         pJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679767; x=1753284567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXRWy2GORatQ4WDqzRgN/A7GONpktQqNYMaPCTvZVp8=;
        b=Fux/5Kbfimow9AFd5+RwF7Urn/Xx+qWbcBo9WnGkSin5Z5q/B9Bqc7ZvRA3LrGpZBf
         WLu/lkYbvi2TjGnlh5ikmBG3WTrAoUsYQ+qFtzhGbUkK7bcQBp/eFO50deMesdyEI7sg
         p9hVWI4cCeofvVDSRoyaRLQzuS5WrB9uLRvRD53ZhfTSG4R+sSA+ud44mNTgbBUlGlie
         P0xnfiOagf2YY6QHfcr0RDmiaapuj5ND38UasOHQXZz7BPJOm3uaPd60WQm/hnSE0teb
         x3gXqQqwZLQKmvG7iHJ4MbmI47MtYL7yycBIm+QB3ENyTKoLzokNAmyG61BDH+36QH7V
         Y8rw==
X-Forwarded-Encrypted: i=1; AJvYcCV6hIpSK+27p43inZTTQsTd8fZDh2Dst9HcJDU1sG7k+XOGpH3D9UU14BbPpxFnFANaFiV+FN8h9rcntkroZg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNuggUDMD+ss0GwmO4T/s7hAzAIlbWvtZ/3QFbfRR0U3X/qd05
	lX1sTWZhd8AdvllevJdVCALgBuESPySQyKe5yaZUC9ggeqf9JYR4Xep3t3Mu9Bc5mIta5TG3BVw
	/YB/UFxe5l4T09JG4yvD/jxDR5d8L0fAoV7SMxKx7
X-Gm-Gg: ASbGncsiMUg59Y/Y35579cZ0mKOwnWWfJI8ln17w84MfBHMx3gIjarKxeUA6LNMpOu/
	MYB6+WJY9jChs0QfkV/Jhrmc3JswR01EjDS2y1b0AC89x31ixOHI4NN1JyXa7IDqzrB89kPqK7t
	kowoUwUNgvzuP8E/IQ1nDnoBx1gy1Q9XektcE0aJi8oO1qHg4gzqQ21nAg2bqtIQ99YKLwOsXcX
	6tx66R7lQLsF4Ttl+u4RBbKl/m57kB/dDVmHA==
X-Google-Smtp-Source: AGHT+IGhWGvZFIyXMBKollBvN/Zu57HCt2PgqO1m3mJKLcpRl1PPfnsYEt1KyZPLSnAw6C1O1yhlRpn8cRFq8axjCvQ=
X-Received: by 2002:a17:90b:1c83:b0:315:9cae:bd8 with SMTP id
 98e67ed59e1d1-31c9e76b79dmr4902000a91.23.1752679766392; Wed, 16 Jul 2025
 08:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250703181018.580833-1-yeoreum.yun@arm.com> <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com> <20250711021100.GA4320@system.software.com>
 <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20250713232740.GA18327@system.software.com> <aHdsQYvKN-dLQG2O@pc636>
In-Reply-To: <aHdsQYvKN-dLQG2O@pc636>
From: Marco Elver <elver@google.com>
Date: Wed, 16 Jul 2025 17:28:49 +0200
X-Gm-Features: Ac12FXyd4otKpgnEaXRLmajtTI6ex6Uy6iZQJFcEjwrCoLj_OCKFTg4M7FvyGmE
Message-ID: <CANpmjNM96MCD-JY=+OkQ4PZK3jV4027PCPRQ0bMVm9kvhGC=4Q@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent possible deadlock
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, Yeo Reum Yun <YeoReum.Yun@arm.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "glider@google.com" <glider@google.com>, 
	"dvyukov@google.com" <dvyukov@google.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, 
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>, "ysk@kzalloc.com" <ysk@kzalloc.com>, 
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, 
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 11:09, Uladzislau Rezki <urezki@gmail.com> wrote:
>
> On Mon, Jul 14, 2025 at 08:27:40AM +0900, Byungchul Park wrote:
> > On Sat, Jul 12, 2025 at 03:46:10PM +0000, Yeo Reum Yun wrote:
> > > Hi ByungChul,
> > >
> > > [...]
> > > > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > > > time complextity looks O(log N).  I don't think an irq disabled section
> > > > of O(log N) is harmful.  I still think using
> > > > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > > > of significant irq delay.  Am I missing something?
> > >
> > > I don't agree for this.
> > > since in PREEMPT_RT case, it has the same problem.
> > >
> > > In case of PREEMPT_RT, spin_lock_irqsave() becomes rt_spin_lock() which is sleepable.
> > > But, KASAN calls "rt_spin_lock()" holding raw_spin_lock_irqsave() which is definitely wrong.
> >
> > It's another issue than irq handling latency, but it's about lock usage
> > correctness.  You are right.
> >
> There is vmalloc_dump_obj() function which should be used IMO:
>
> <snip>
> pr_err("The buggy address %px belongs to a vmalloc virtual mapping, dump it...\n", addr);
> vmalloc_dump_obj(addr);
> <snip>
>
> we use trylock there to eliminate an issue if invoked from the IRQ
> context.

Something like that should work:
https://lkml.kernel.org/r/20250716152448.3877201-1-elver@google.com
