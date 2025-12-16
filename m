Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40F358D1E
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Dec 2025 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888767; cv=none; b=Zpe/ULEsqesxBQ7mHB99hYb871Y2k6myVP6jtOwfWQ4qAShZOqGzzPKKJ6bh8J4xiCffIjRb0By2IfXU0Bz0DX4yMM0LQYO/vpgdtnxcTQjmzdRPFO5yGJXKxglSwUrBv27suZscRIAyV2jfIKbTDVyQuA2OhKamDg45VehycFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888767; c=relaxed/simple;
	bh=ODOFXdKh7a/2yyeolj4dfSpZo/cGD6EWg9Uz8WCXsU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ud7FvoEkiz59OuYF5h4yylRuXbJRKQWe9JNjBbX9GqaWkxv1TT7CUsLa7mGmAbOsydC3fwFdVczUjyGQ8u6BlArTFgft5/1WO8+GxM+2bUr/SnNxgQjFW1oic9gHL9OV7qgKzPhfGDo7TVOtNYEsA3+nAMfGXo9ftn3ffBCbb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1tpeg+s8; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1tpeg+s8"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6417b2fae83so5132869a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Dec 2025 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765888764; x=1766493564; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl5vYkOfCeh8vzJ1i3gRdGX7RBaO+Y5siaEC/TfzJu8=;
        b=1tpeg+s89juF1fRpGifB0NGlQkeZB6hbyKJzMNX+W4NwU+3WD74eMaR2nck5rO5KGS
         o+tkM9RhSSsw9qeeZrpTm2M9eeJ6PvaCOE4zGB/WLGNEqf/ah5htrXLpB1YGr5FKFfgp
         eOicXmETbCzY9TyYJOb0UJFdKXDz2ro0OMz8ga4lyEoCFVQMA+p99iXOCsWGqQqg2ybD
         Lm6TtWNAYWZxbV/vCgCdbEbRLitFLZ10nNcjOGGkCmAtjrc6twzUbkQ0vn0IY5dhPJ0x
         UBFJ99dwf4Bsmio5QnS00bvTtha0hej+bNjsJKqC3IOvSqLCl4U/yFhzT+pqQQfq63ZZ
         fedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765888764; x=1766493564;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zl5vYkOfCeh8vzJ1i3gRdGX7RBaO+Y5siaEC/TfzJu8=;
        b=Jgt/jyPcv7soRLKyfvRdLrUHCwwWSOY1myidigKxJlnWOGi8+y4/lpk14HzpGxY+/3
         +0NQ78sWGXcmEa1KHojvSEAJ225rFzxVmL1+HaAGtrQevIEM5yi430nJhtTFVpAuZcoc
         KQwZoaqIOqPFynnOd0mB755i1J5Br6oO8GZmo6sVae38dDd1COb4Yk+imflJ9ELt9+wY
         +2TpY9n/7sFCQN0mzTecm5OXnPbGL2BVIj82al70uBpyMKQ4Hu/2vJg2jWC7FdSvXfjL
         nNYo2eLbi8Y5u9v6VH0Kmtv89/AQCzGoY2HqNhjhKMvwdt/FwSXvHvTjkfIqf20rOfJx
         f/cw==
X-Forwarded-Encrypted: i=1; AJvYcCXFhX6dJd5/kBxUflCn6G+C5/MWnEzMKfnHnilH6V0ayUFenHuYilOg/aNjMocagcQ29QcgMNUIGCo67Zs9lw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhUQkbt44jqEeB6aZpYdJI9wPluvsjXfW73KTgnJPyD6et23hc
	Z37z9ctgrH2a8GepkUBPOH2IavskqPMrIGPuEzmZtbSBrqfsp4JyoY4S3IJG9yPTuCHFIW5GE7j
	i7T6HC8mbzTnxYw==
X-Google-Smtp-Source: AGHT+IHodb6E0igt70QWnGwF16M0BauoX0vq/LCQAwB66mdazNxScaNnSE8J8M2KteYx3re6oS8FbB6Lsn9MBw==
X-Received: from edsk11.prod.google.com ([2002:aa7:d8cb:0:b0:643:12a9:41be])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:50c8:b0:64b:3a87:44ff with SMTP id 4fb4d7f45d1cf-64b3a874559mr607042a12.34.1765888763584;
 Tue, 16 Dec 2025 04:39:23 -0800 (PST)
Date: Tue, 16 Dec 2025 12:39:22 +0000
In-Reply-To: <aUFKAdPY3zTlPmnr@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251212161832.2067134-3-yeoreum.yun@arm.com> <CA+i-1C2e7QNTy5u=HF7tLsLXLq4xYbMTCbNjWGAxHz4uwgR05g@mail.gmail.com>
 <aT5/y3cSGIzi2K+m@e129823.arm.com> <DEYOI8H2OESD.1H56D3H8HKILB@google.com>
 <aT/WOAr4osoJWaMS@e129823.arm.com> <DEYP7JSVTB9D.3EFN2KEHH3O79@google.com>
 <aT/drjN1BkvyAGoi@e129823.arm.com> <DEZK5U2YP6I0.27VJHSVK14646@google.com>
 <aUE8bwUVa6jSUft1@e129823.arm.com> <DEZLRT59S25H.2YWTZ2G0TN3HV@google.com> <aUFKAdPY3zTlPmnr@e129823.arm.com>
X-Mailer: aerc 0.21.0
Message-ID: <DEZNBMBRM5M2.1974FFAQ13G5E@google.com>
Subject: Re: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
From: Brendan Jackman <jackmanb@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Brendan Jackman <jackmanb@google.com>
Cc: <akpm@linux-foundation.org>, <david@kernel.org>, 
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>, 
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ast@kernel.org>, 
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>, 
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>, 
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>, 
	<haoluo@google.com>, <jolsa@kernel.org>, <hannes@cmpxchg.org>, 
	<ziy@nvidia.com>, <bigeasy@linutronix.de>, <clrkwllms@kernel.org>, 
	<rostedt@goodmis.org>, <catalin.marinas@arm.com>, <will@kernel.org>, 
	<ryan.roberts@arm.com>, <kevin.brodsky@arm.com>, <dev.jain@arm.com>, 
	<yang@os.amperecomputing.com>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, 
	<linux-rt-devel@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue Dec 16, 2025 at 12:01 PM UTC, Yeoreum Yun wrote:
>> On Tue Dec 16, 2025 at 11:03 AM UTC, Yeoreum Yun wrote:
>> > Hi Brendan,
>> >
>> >> On Mon Dec 15, 2025 at 10:06 AM UTC, Yeoreum Yun wrote:
>> >> [snip]
>> >> >> Overall I am feeling a bit uncomfortable about this use of _nolock=
, but
>> >> >> I am also feeling pretty ignorant about PREEMPT_RT and also about =
this
>> >> >> arm64 code, so I am hesitant to suggest alternatives, I hope someo=
ne
>> >> >> else can offer some input here...
>> >> >
>> >> > I understand. However, as I mentioned earlier,
>> >> > my main intention was to hear opinions specifically about memory co=
ntention.
>> >> >
>> >> > That said, if there is no memory contention,
>> >> > I don=E2=80=99t think using the _nolock API is necessarily a bad ap=
proach.
>> >>
>> >>
>> >> > In fact, I believe a bigger issue is that, under PREEMPT_RT,
>> >> > code that uses the regular memory allocation APIs may give users th=
e false impression
>> >> > that those APIs are =E2=80=9Csafe to use,=E2=80=9D even though they=
 are not.
>> >>
>> >> Yeah, I share this concern. I would bet I have written code that's
>> >> broken under PREEMPT_RT (luckily only in Google's kernel fork). The
>> >> comment for GFP_ATOMIC says:
>> >>
>> >>  * %GFP_ATOMIC users can not sleep and need the allocation to succeed=
. A lower
>> >>  * watermark is applied to allow access to "atomic reserves".
>> >>  * The current implementation doesn't support NMI and few other stric=
t
>> >>  * non-preemptive contexts (e.g. raw_spin_lock). The same applies to =
%GFP_NOWAIT.
>> >>
>> >> It kinda sounds like it's supposed to be OK to use GFP_ATOMIC in a
>> >> normal preempt_disable() context. So do you know exactly why it's
>> >> invalid to use it in this stop_machine() context here? Maybe we need =
to
>> >> update this comment.
>> >
>> > In non-PREEMPT_RT configurations, this is fine to use.
>> > However, in PREEMPT_RT, it should not be used because
>> > spin_lock becomes a sleepable lock backed by an rt-mutex.
>> >
>> > From Documentation/locking/locktypes.rst:
>> >
>> >   The fact that PREEMPT_RT changes the lock category of spinlock_t and
>> >   rwlock_t from spinning to sleeping.
>> >
>> > As you know, all locks related to memory allocation
>> > (e.g., zone_lock, PCP locks, etc.) use spin_lock,
>> > which becomes sleepable under PREEMPT_RT.
>> >
>> > The callback of stop_machine() is executed in a preemption-disabled co=
ntext
>> > (see cpu_stopper_thread()). In this context, if it fails to acquire a =
spinlock
>> > during memory allocation,
>> > the task would be able to go to sleep while preemption is disabled,
>> > which is an obviously problematic situation.
>>
>> But this is what I mean, doesn't this sound like the GFP_ATOMIC comment
>> I quoted is wrong (or at least, it implies things which are wrong)? The
>> comment refers specifically to raw_spin_lock() and "strict
>> non-preemptive contexts". Which sounds like it is being written with
>> PREEMPT_RT in mind. But that doesn't really match what you've said.
>
> No. I think the comment of GFP_ATOMIC is right.
> It definitely said:
>   The current implementation *doesn't support* NMI and few other strict
>   *non-preemptive contexts (e.g. raw_spin_lock)*.

But this phrasing sounds like there are other non-preemptive contexts
that it _does_ support. I would definitely read this as implying that
plain old preempt_disable() is OK. I don't understand what those "few
other strict contexts" are, nor why the stop_machine() context is
included in them.

