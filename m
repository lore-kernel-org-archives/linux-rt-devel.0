Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F0205E3B
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Jul 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224081; cv=none; b=egYjHF7Kmb8kEDa+BBAP7l13+4xb6Ep2aVHcdAurHoZwN1hIbXh6OVwm7Z4Ni9lJ9RAA/NQWKX/YAlRPuAhJ2yMcACdUvc4NHMxWb7IL8ZF1FUJFF3eVZ8XYjO4bf+fmN+FrKqVCIxiove8IDNlUrsIpP4AqhYPALvOVKOs7fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224081; c=relaxed/simple;
	bh=nc/SvkTbpBhT+d4ORjgE3oFjs6JCVP03Zm2AtIezNs0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9tRHduoy+71Pn6jPDU/hn/OzWwHbBtIlp9I+JvnmL4TTjLLY2gssNzPe8Ys3mAUMVvi+DCNPVBG0jlSPCdwwAlSHG0s4jX0RzsURjuYkXA5fqz5KDL0WlaHJYVVt0+P+5suIhdDRmL41kTiuygukdLqQlkgQ1r3rYq2j/1Vl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ssa8isJ5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssa8isJ5"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso2088787e87.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 11 Jul 2025 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224076; x=1752828876; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ziEQtJ6TzJ+Y/Zcb94FyvvcznpnXNVBhWXC9sDmSYV4=;
        b=Ssa8isJ58gVmaWB9UMum3mEoRzZ7t8qcVm0EFelWZ9tAP3NX9lXrAUTWweY9UH6Ew4
         pPHTq2MSZrRHIXAKp8aSr/0TJiKsidlFMcwdu9OGcmNtshu1i9BWIPqtsf6RQQRPR4gs
         fZR57FBTgOPBC8h4TckYrmYx1f4+mdHR8ffK2fjLyE+iHisy8UCmSa2eMAQ/rxRv/Qma
         iK0Jp8rSUMLze8ldJc36QmK/cPE/XhzxAEr0C6m74m9LeucFy9wNFsA3biLJYsda3CNB
         ADC1KTawO1dWJLGKOJm/n+DZkAf1hjISEIiio96vQkaxBlG6WkTAAF0rLMX7peNI0cVp
         IP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224076; x=1752828876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziEQtJ6TzJ+Y/Zcb94FyvvcznpnXNVBhWXC9sDmSYV4=;
        b=nIgvgE3iKF0CVTk8SUsXSed+CcKeK9plFwtDOF+HMDOSdV7+D43SNPB1t6PV3K3fE2
         0ZLFaXiofMHsA1nbVr0iIb96A/gu2EMBgZVoYh+0l6qih8/I2RY//wRx8YN4R9TIH+Yi
         ROnaKmvNjs6EPFKjmfDQKUbLcThWV5XcTlPW+U7DbgiqNijGmETIPyU2hoHViCNbMZuE
         XqG8DGkz5lKhADPRExzY6/d3eXrIfnMbVe8VMPrCWwaBSOFhTk2BcROZ3MJcUWguT6Ws
         ZDST4wnbmqZQ5S4rjzo7wfX9/+MDTgcFSr1dmf8acsuAnOXdW83c+guSA3S1s0S2nP85
         fspw==
X-Forwarded-Encrypted: i=1; AJvYcCViGFiZV+HfDMwmHy5FDIuez+WpE+v8ScoVoKCayYqUWaIRC2rBITKeFc5py6uU6VgbxmiCv0EIUAFDtdIUqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWbrMrwJ2mNqHO1hrAiV3ias50UkXR3TUQXH4Ez9KK7Siv7W5k
	opB94TEwACBbO9bF+iWfysKKTynZqIUuQ/pAKRlO32WiqRNYKvF7vqj6
X-Gm-Gg: ASbGncvJsuwavgJgkOBQDIXHy2CAPqrWlw3YjVSQSqr9DmKxF3HbX9y0boJzL+R69L5
	Ax5JDghHzV6Dpc4An/41AnF+o95ZRHEKEcRdVCeFXVzy2L6GGmMteHFzdNbE7OPX0BbJ13wOJvJ
	dE0nhj3J+lmBrZfgKlSPeibzFZpI5BnKF9iMb1nIZfifGZ36tMoaocH+7Fsz/bHcimhsXOWwrZc
	X7dL7uzNHMbyTxl633cH2QHvIQfFiAnUe6jjsaV2TXzzi3oP5yqvf3uDW5OZ+7pVo3GtNCJCAsR
	LqcQmp4V3A9gG4PdnpY+HG7b3+f5MmLrPR4gnZKMfaVgt/HSRpI9oCdJWC4jDELB+/ffgK/0/ZP
	Sx200aVoWMngLbO9aE2Saf2yKBptbwZek5uFqeTum2sY0apQb7w==
X-Google-Smtp-Source: AGHT+IFPqpkRmTjKeGpVvTou+tnFlMgMi9ZNeCVtfH9Y1Rk4EXvSbZNZFUirIWgtanrq34tOCvqwWg==
X-Received: by 2002:a05:6512:e9e:b0:553:543d:d996 with SMTP id 2adb3069b0e04-55a04609b15mr657418e87.33.1752224075346;
        Fri, 11 Jul 2025 01:54:35 -0700 (PDT)
Received: from pc636 (host-90-233-194-86.mobileonline.telia.com. [90.233.194.86])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7a6f2sm820437e87.235.2025.07.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 01:54:34 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 11 Jul 2025 10:54:31 +0200
To: Byungchul Park <byungchul@sk.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>, akpm@linux-foundation.org,
	glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <aHDRR6WBISSljdcd@pc636>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <CA+fCnZcMpi6sUW2ksd_r1D78D8qnKag41HNYCHz=HM1-DL71jg@mail.gmail.com>
 <20250711020858.GA78977@system.software.com>
 <20250711021100.GA4320@system.software.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711021100.GA4320@system.software.com>

On Fri, Jul 11, 2025 at 11:11:00AM +0900, Byungchul Park wrote:
> On Fri, Jul 11, 2025 at 11:08:58AM +0900, Byungchul Park wrote:
> > On Thu, Jul 10, 2025 at 02:43:15PM +0200, Andrey Konovalov wrote:
> > > On Thu, Jul 3, 2025 at 8:10 PM Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> > > >
> > > > find_vm_area() couldn't be called in atomic_context.
> > > > If find_vm_area() is called to reports vm area information,
> > > > kasan can trigger deadlock like:
> > > >
> > > > CPU0                                CPU1
> > > > vmalloc();
> > > >  alloc_vmap_area();
> > > >   spin_lock(&vn->busy.lock)
> > > >                                     spin_lock_bh(&some_lock);
> > > >    <interrupt occurs>
> > > >    <in softirq>
> > > >    spin_lock(&some_lock);
> > > >                                     <access invalid address>
> > > >                                     kasan_report();
> > > >                                      print_report();
> > > >                                       print_address_description();
> > > >                                        kasan_find_vm_area();
> > > >                                         find_vm_area();
> > > >                                          spin_lock(&vn->busy.lock) // deadlock!
> > > >
> > > > To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().
> > > >
> > > > Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> > > > Reported-by: Yunseong Kim <ysk@kzalloc.com>
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > 
> > > As a fix:
> > > 
> > > Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > 
> > > But it would be great to figure out a way to eventually restore this
> > > functionality; I'll file a bug for this once this patch lands. The
> > > virtual mapping info helps with real issues: e.g. just recently it
> > > helped me to quickly see the issue that caused a false-positive report
> > 
> > I checked the critical section by &vn->busy.lock in find_vm_area().  The
> > time complextity looks O(log N).  I don't think an irq disabled section
> > of O(log N) is harmful.  I still think using
> > spin_lock_irqsave(&vn->busy.lock) can resolve this issue with no worry
> > of significant irq delay.  Am I missing something?
> 
> I prefer this one tho.
> 
> 	Byungchul
> > 
> > If it's unacceptable for some reasons, why don't we introduce kind of
> > try_find_vm_area() using trylock so as to go ahead only if there's no
> > lock contention?
> > 
>
I wish we get rid of using the find_vm_area() from already existing
users including KASAN outside of vmalloc. In some sense it is not
safe to access a VA because of "use after free" issues.

--
Uladzislau Rezki
