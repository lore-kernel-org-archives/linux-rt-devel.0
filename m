Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257334AB03
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951887; cv=pass; b=fak+bMM2+EP00jI9dGusBhtiio0Qlky551tMy4+123GdPshG4+3UI9ulIKCG1BKRUjqgAhN/w90NA8mjKEm0AgyxOa7AvvNfLgBJrDdlNIC7QwwCEMD4hl1EB0RhLpiJBdJ4ulqp7TDpWLV9a3cIYgFsExhtThq7KUHPqaaOyks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951887; c=relaxed/simple;
	bh=OFShOOL1jw7qJlGJEKJyhIQfr46/SV34zO6TPF0C7C4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzDvCvvr8nBrWwAKkl/KZUOUWkJyY990DgwXswBGsr09lECCDb48jVJrQDhytGEpJ8PVzItN9vKsp/x01O6y6hond4LeNYz/PyZ8tGA8VHCUrmDcQKxeXD/gkHGnkkX9gvo8vfJuHdJSSMIdJSZBvuCGAnr9k3IPK2RgfSRVTqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzOdq6AY; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzOdq6AY"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso2285e87.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 14:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787951884; cv=none;
        d=google.com; s=arc-20260327;
        b=X1dvTqTfTDMPvV6i6oViLkHGQSy0bs6fzxfTK/32ZN4Q3iP9UEPaSNbhdBSaEFltxV
         /RzMZPV25hAOWlwnmh+9ubaaxMaJltQvNsyzVrwEj9oMbByMI/UtScPKkQ1NdS06qhbf
         ipSNspY8K2bCCZ2x3a+iL4QPDhi8PY3D2UJPRNZ9hTlG435zkJuPAOPwQ49dHi74ZUwW
         SGjKsrsfZpkJTLgRGZVD097RroDAUjTX8bM2iJDpKGAjeCLpyRmm96rez1cMHwjt55X1
         i6wjEacfZv3wkn7hqdzAkNLM231dKzpu6K8h2ZvTP7JfJGKG9Y6n6of8eP3CrQaVE0Ix
         9NZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ox47LSGNLn4iYQakTpAdrm+z1IZQvt0QyHLEVX+5st8=;
        fh=9nAj6Bgj6Wm2wneT6B09m32NsR7Hsbn0euX/Cu4IGk4=;
        b=iilyGfxB6Vp1jqenJl2o7lmE1JDQoz8SKjVxAs7VELJVzcdS7ZVB5CRU2jceXuxRkS
         QOAK2ZvybpXfJ/Gaw8pFWHv5NIRq4sOkNd5EUtEhrNyApPSEMOTkUwPjYkFRW37m8VV/
         lIA9Ee59kXsrnVqDVdS+0IRir3vT+b4WMGjHBpF/f8YzWWS6RCql7Bhb8Gi0BiPoMYdw
         T5QdQ/pF/4UHL5pVs0YGkvEgDgyAWTyyA0BAarQBfVz6/BmVfpqpe8LPfAhog0Ej84pb
         lP82TaHcAGhLxUkVxci9DKeNFNeMFw9k65L/WnUzqwuZ/qvYAEVln9F0F1we2Nf2RZvG
         wPzA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787951884; x=1788556684; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ox47LSGNLn4iYQakTpAdrm+z1IZQvt0QyHLEVX+5st8=;
        b=VzOdq6AYj0Yr2juZgLE8kjpJG35nYhOeGg9pQwrREVGQ4l42d5kiV85znSYZ8Bsk7S
         cpctScbprJTPv55jq8upPCCLkWQvllUNMu+0PDGuPwNV9/IubZ2hSY70COC17hcHuAuU
         ajPF4UpeOrb0c+wo4UU4dlMsECf91DWFxz9sGHimYOS+sTgfCaTl1AeBXp5wynrEl8VS
         lnDvMOmj1gu4BR8D/J0DQjeO+INtHpoUxRsMiPO7IB7R5nEtpbznKsAw5E8JevvunliS
         pSlds77qEYu7SbA7V8u1QXmLi7bWWlNQ03alfrwkiJfw7AKV9YGeIDLjAgE2cb+h5BIq
         RQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951884; x=1788556684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ox47LSGNLn4iYQakTpAdrm+z1IZQvt0QyHLEVX+5st8=;
        b=BpvCIw0a27G8kFdjM0llAfseVHyTAQH1PJ/vZvVMSsj9jQRlN381Ll2VnfxT/9RSwY
         L4+em5BRkA5ruw1fsjAxkObnvY415q7MRjZjevt8AXwmBSUuiRHLPasiYUjNMDb6TPu/
         4T3uQMt1YzVjyyHbHebua4HophrXPGy4JYiem8rOss8t1WXB3bTurVhEt/mR/qXKLgvc
         BBhKThMRhQyaN14s3zhQ+Xz54kTeswSEqiRmGmanIZZHBrW+83Tgu2GtIHAZ6LK0Ezhe
         zifhSEK/hloNHDLjWsaUbXChToiHhaCkKoJwRs7qJPwuPv7ozQGUjydxacQDhy5k7HpR
         cZ0g==
X-Forwarded-Encrypted: i=1; AHgh+Rp9JCkQG31x6C+qp6JHuPgA3muTLDErnrR12qTzIeLw7ekz/g0sHE9YqzngzWNA9rWkM+L1TGsehElNK5DGlA==@lists.linux.dev
X-Gm-Message-State: AFuF++lijeENVqMLDs+fhvZvGhjtLWcRckel47KIbquKqL/BCgfEsGll
	jpDxBKcI0dxN45meA65YnlTq0JFIwtSXVjzseGZzruazFKIlA3H2zYv5YO0D1Fk3r0z9R0a35CW
	McFugzQ6hVFcXbgJkcNQSuFZ4Z5VOR1XrbP6u0kup
X-Gm-Gg: AR+sD11yPegzsK2dCSAcVRZlLNWcXAQz+qXiFqpWXVevQMGF3V8YNA5dOhrlZyKJ/21
	wPBg/uVAjE8qvaf4IYcO0rWvPE3l4+x8xc7+8orFKW+nf8xm/g414Fqo57eOVUfaWIiJpg3YsJL
	oz8CD48DGukxt1ZYFS86Qkecgr9ID9tqnJg54mSpPQ78AyIGbfJgG2lcnuGhJ/G4uhZNNle/xRA
	1hUk4Qt2VHj0cSWaOTR8d+fP+YSHSrEGY06crUfThu6ibMKEFxEh0ntxLPegcQV6qSjfBfcTvwa
	lJhfWfBlxGKaupgiqw8o8pJoNskWDTRTYUDpjQSyYgL/LGLwlOY9HwIorc+/q8KBSP3cGsAHYTD
	E
X-Received: by 2002:a05:6512:1594:b0:5b2:a967:c0c9 with SMTP id
 2adb3069b0e04-5b5ef2283a7mr31129e87.7.1787951883225; Fri, 28 Aug 2026
 14:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com> <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
In-Reply-To: <20260828133620._x2XfJR_@linutronix.de>
From: David Stevens <stevensd@google.com>
Date: Fri, 28 Aug 2026 14:17:49 -0700
X-Gm-Features: AcwNN1XPwhnUNeipFck3Fo-JT824naG0Joeg5blGOWBTdqacwVpK3ww48maahZk
Message-ID: <CAOiLmNHK5Hw55omycg_EAHzi=g1iqJn1NTap1Mt98im3xTXcvA@mail.gmail.com>
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 6:36=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-08-27 16:29:44 [-0700], David Stevens wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index fa7507ac8e13..adb4a5957996 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1534,6 +1534,24 @@ config VMAP_STACK
> >         backing virtual mappings with real shadow memory, and KASAN_VMA=
LLOC
> >         must be enabled.
> >
> > +config HAVE_ARCH_RECLAIMABLE_STACK
> > +     def_bool n
> > +
> > +config RECLAIMABLE_STACK
> > +     default !PREEMPT_RT && !PROC_KCORE
>
> This shouldn't default like this for RT. It either is useable or it is
> not.
>
> > +     bool "Allow stacks of some blocked threads to be reclaimed"
> > +     depends on VMAP_STACK && !STACK_GROWSUP
> > +     depends on HAVE_ARCH_RECLAIMABLE_STACK
> > +     depends on !DEBUG_STACK_USAGE
> > +     depends on !KASAN_VMALLOC # TODO: add support for this
> > +     depends on !DEBUG_KMEMLEAK # TODO: add support for this
> > +     help
> > +       Enable this to allow the unused portion of kernel stacks of mos=
t
> > +       blocked tasks to be reclaimed.
> > +
> > +       The wakeup latency of tasks with reclaimed stacks may increase,
> > +       especially while the system is under memory pressure.
>
> It says *may* increase and on RT it _definitely_ will increase since
> there is a kworker involved not to mention the memory allocation itself.

You're correct that this phrasing is wrong. A more accurate way to say
it might be: "Under memory pressure, tasks that are not scheduled for
extended periods may have their stacks reclaimed. Such tasks will
experience increased wakeup latency."

> Anyway. This either needs to stay away from PREEMPT_RT or find a way to
> exclude at the very least mlock()ed tasks.

Disabling kernel stack reclaim for mlockall() tasks definitely makes sense.

> Did lockdep see this?

What are you referring to by "this"? I did stress testing with lockdep
enabled and didn't see any errors, although I will admit the bulk of
that stress testing was !PREEMPT_RT.

> If I understood the whole exercise correct then you have a kernel stack
> of two pages and in best case you can unmap and release the second page
> while the task is napping.
>
> What might be a tad simpler is to memset(,0,) the remaining part of the
> stack. Since the stack is vmap-ed it should be swapped out on its own
> without additional tricks. That memset() would help zram to compress
> better so it uses less memory. ta-da.
>
> What also should be simpler (and I am not saying just to move you away
> from the scheduler) is to have a shrinker which iterates over all tasks
> which are marked for reclaim and then similar to swap just unmap both
> stack pages and release the second page which is not used.
> Upon wake up the task should create a page_fault which would be used to
> allocate the second stack page and map the whole stack again.
>
> This sounds simpler.

There is no swap for kernel memory, only user memory. I did contribute
to some previous work that aimed to only only prepopulate one page of
each kernel stack and then to dynamically fault in further pages as
needed [1], but handling that architecturally and guaranteeing that
memory is available when needed is difficult. Full-on swap to zram
within the kernel would complicate pre-allocating pages for kernel
stack faults further, since you could start getting inter-thread
kernel stack faults due to blocked tasks putting pointers to their
stacks into waitqueues and similar structures.

[1] https://lore.kernel.org/linux-mm/20260424191456.2679717-1-stevensd@goog=
le.com/#r
