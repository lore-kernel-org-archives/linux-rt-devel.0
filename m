Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC622F2369
	for <linux-rt-devel@lists.linux.dev>; Wed, 16 Jul 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656968; cv=none; b=tqNMtj10tUaD93wyAjj5WHiKJfvdHBAj7FVRv1RvSeywOQAFtvWyysY118WFcP01SJ4Tro0VeVx443zGOnhEQEMR/2/E384zje+VUXml/aT3yBy9V6jWw7Gbg8Qzs1MviKNmMTHVTp5cu7UNkuzQIjFVUj7Avlgz2KNHBBh0qis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656968; c=relaxed/simple;
	bh=Wlyj5BDsEtRjW9virg0GuEbkQegL6rlEcKbTaJYzgE4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZsJ7aP2HnlG1xIrPIYLNSdut8zyD4hhALqWCIaBEZhkP11aijhZ3EGkVQp6EPfpxZA3vz6vAyNKooD4qY+2UOg8LdFxFCpbkm+HQJKkacOz1tupdiM8SKezeqY8WErgDI6oo4GKCYW8fZ1IKcm5jYmbGMpLM4FCXB5p/vj2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4xCSRIB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4xCSRIB"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553c31542b1so6015326e87.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 16 Jul 2025 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752656965; x=1753261765; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2eOTiw68BIyhYHvtk2S5wRVGB/8ahHu3vX68UO+Adzs=;
        b=N4xCSRIBrs7KqEsZkDO37aETugvCO0MzMEOb+p2lY8lxY20E9CEmebvr8EmEUDZ7XV
         KMURwKUiWj2/7xtUPLTak2SpScG4hWIe7FZhtBYFlKToJFC9u+FQolQf+ffj9YU/6fSK
         FIe5Bi51IKwc21H2aAGyVH2JIeb1DdPLXGx16EASP5y4/nx89TLuewzTnclxSHTbvOXc
         DIdiUGXw4JA8SCUAQ754qIw0FUdxgw2tv+J+nvsibot7vCyAFHDU6wwJE8ft4fxMviKo
         R7DMQRMCok7M0ACCvRiywA4xIrqvX9qNlO1P/gHzHGyQrPDSG4jq8l0oCCZ/pepc9LcW
         Dy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656965; x=1753261765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eOTiw68BIyhYHvtk2S5wRVGB/8ahHu3vX68UO+Adzs=;
        b=R02Jr42xxegA4eyPBB4XV5bw9tBtcytIJi50fhw5eitThFe0+5UluGCwzWwmX8oaL4
         i+eiuHEA1uatkfUKxQEQu3gq3ujuTHitQFqS8EFeitsJE9qLwCKxFp7umJJolAN1iets
         gm9DAb/3BndhAOh5R/uV93EdaXBa2w+HN3WQkhjtEi2Ue7/SqRsFWc5EMZJwnxZKZ2FD
         mwCJ024ozOnq7QV4WqQJJ4Q86VeJ/mFQ5Ijz5bTGS7qUu1NyUoN/z4MBNauZ3stUKXEA
         RSBGzNtSnuD9+BGLgL3n+bpk6xGA9DRk3JWJm50NJ8lCmfbQhW519q6gOuhTNvR4Oc5s
         x45Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx5PkfgHl42xGecwGa0LgehDmVkhy2n1gZGpnVMGJ8D2cCSx198Ewb39L8QB6k8O6vDOiCTT6Bcijt1Q4ztg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO3V4BezPcoP1tUJjTJrUg6f40U+IpyO4bmjGn0imWCEI6lRDB
	i0IGCrd044BnNJ9vf0+G+du+toI2cSeQGDtc3MGJ6AgNpDGF07NWRPgg
X-Gm-Gg: ASbGncuab52sKP3YG9Mbo2DyxHXvBl36VD+cYgtp7iCOAAcdpR1Ncfm9TM3NIYzFgKi
	Difq/XBfeLHqnB02eLWQYd+ZDCByyfx/TnN3aEFKKM1OB5oeqXAmaQRyFVjscDpO5+80ek/pbwF
	WON3FkpjD7THpG6zgUyNrSfoNzcGqc/Juf3BgORjhVJbCcrUob7TeIIYkv3h+FDNcu0g4Y462Wi
	z7csXfnIb15kcyasHr1N8jjsM9fyYvW/RB7fdJT34Xu4VMYudgD5gz933qE8bHX7qPZiPIvkV/J
	GPVxaSS/DiV/vMV493d5F78WKfQnN0t3iofvFC3qj4wOYkRjj752hMehdwURScYmorfx6RPU9iq
	lwE2D25+7GytCJJYM2u4RFrI4IW6j3mEPNttHR55Roa3gu6o=
X-Google-Smtp-Source: AGHT+IG5WLfntZKDWbVYrqQzZ0ESIP+d42sAu4LjtSqz7jbMmWEtzmxAMa2+osPJFNGzNyu9Jnn4yg==
X-Received: by 2002:a05:6512:1313:b0:553:1f90:cca4 with SMTP id 2adb3069b0e04-55a23eef245mr521782e87.13.1752656964569;
        Wed, 16 Jul 2025 02:09:24 -0700 (PDT)
Received: from pc636 (host-95-203-27-91.mobileonline.telia.com. [95.203.27.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f1fsm2561084e87.107.2025.07.16.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:09:23 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Jul 2025 11:09:21 +0200
To: Byungchul Park <byungchul@sk.com>, Yeo Reum Yun <YeoReum.Yun@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Cc: Yeo Reum Yun <YeoReum.Yun@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"glider@google.com" <glider@google.com>,
	"dvyukov@google.com" <dvyukov@google.com>,
	Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"clrkwllms@kernel.org" <clrkwllms@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"max.byungchul.park@gmail.com" <max.byungchul.park@gmail.com>,
	"ysk@kzalloc.com" <ysk@kzalloc.com>,
	"kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	"kernel_team@skhynix.com" <kernel_team@skhynix.com>,
	"urezki@gmail.com" <urezki@gmail.com>
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aHdsQYvKN-dLQG2O@pc636>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
 <20250711021100.GA4320@system.software.com>
 <GV1PR08MB1052126BB553BD36DA768C998FB4AA@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <20250713232740.GA18327@system.software.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713232740.GA18327@system.software.com>

On Mon, Jul 14, 2025 at 08:27:40AM +0900, Byungchul Park wrote:
> On Sat, Jul 12, 2025 at 03:46:10PM +0000, Yeo Reum Yun wrote:
> > Hi ByungChul,
> > 
> > [...]
> > > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > > time complextity looks O(log N).  I don't think an irq disabled section
> > > of O(log N) is harmful.  I still think using
> > > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > > of significant irq delay.  Am I missing something?
> > 
> > I don't agree for this.
> > since in PREEMPT_RT case, it has the same problem.
> > 
> > In case of PREEMPT_RT, spin_lock_irqsave() becomes rt_spin_lock() which is sleepable.
> > But, KASAN calls "rt_spin_lock()" holding raw_spin_lock_irqsave() which is definitely wrong.
> 
> It's another issue than irq handling latency, but it's about lock usage
> correctness.  You are right.
> 
There is vmalloc_dump_obj() function which should be used IMO:

<snip>
pr_err("The buggy address %px belongs to a vmalloc virtual mapping, dump it...\n", addr);
vmalloc_dump_obj(addr);
<snip>

we use trylock there to eliminate an issue if invoked from the IRQ
context.

--
Uladzislau Rezki
