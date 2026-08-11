Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292E38D3F9
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489087; cv=none; b=aZz4XKi3TACFChPV9tav50C1y3oVCkMYB11jOT2EwxHsGkxNSDmGllGj0F2tfOYPZGrQFtE+/YbppLG/5H3acpUIry//tVCvw2CiSWa2dR/laD5G0g3712ImMupzA2meB8YM8mbE4R2pndo9ORIiw37jvq9nNuHPBOTliapDo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489087; c=relaxed/simple;
	bh=HgHvOCxjxAKo1KYeiWhZk6fIUQpt9oKnV2zvDdq7/kE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H9SPL/xbosML/tVwG7Bu8GPvgxctNkXGIIfMxh8/DdqYPMSoRTb0dzjUMmkO9lOMBgWt1t6f64X3cWcbF0bdr7uTI+u6QrasL6H2bB/PdI2er5ba+xB8sTAjQW+terv/7zyXBrAlrSCL4chPyFo9P7A1+dFobxf50LTwepXFN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4kRHEnW; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4kRHEnW"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e375d9736so177296b3a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786489085; x=1787093885; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cEzv9TziceYkcHbMHh7lHIVizJF1nhviTwKFOEAR9lQ=;
        b=I4kRHEnWxs+o/W/Icwd2gKmU52GMUHr/5ykf7iQeslj4enfSL0PFNhtDtNzP4AjS2m
         +WmnZgzqL3GqymwfuFJ2MMndZtiMokD1HYB7j2yojt1SrVEN7WrOJBhttfZewSk22hjW
         iHZ5rK1PNCnLxcjrZIfAcREsItvq/U9SvuffpNo5seb4SXmuyGR7tSnOlyhBeUz5AI1L
         8RKW9SdSOPnXCPxJPmvQUEaMfFMuMHqLfFmsfqfS9WaiqoFQ9+bIDnL16VUdB6vnU1wv
         D6xagXQ0PTinLlDc29O4NAtN3Tp7Cac7CgEAW02VYQQazrzBQNhDHNxLcfPWcU23bzgi
         A1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786489085; x=1787093885;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEzv9TziceYkcHbMHh7lHIVizJF1nhviTwKFOEAR9lQ=;
        b=TaXv2/dodq9pU02dGbYiYnTCyoZgFIwldJUGwFvyGOaYVaYo7RSeILkSwLPRfPS1k0
         Ml+UH1+HI6xXNuYKxJAjbU4a2OyZUsCQ6ovR4e9J3yEekq5n8IQqzg4idMXUmUk+74xc
         VQhC6+bGOWe0lG4Dex8o1guVh2xIhxDZfqiQIr1vS+gMUQLjf/CkBq8m+wRqDoQ82Z6e
         sPdO2TOXepMeQyOQ3DJyrvB5xD5GmCPXO8AbtEttLrqlf5ZV2L45pjY9diB3afnEWHf7
         HHz8OjqgCQ46SDdsd1wmKCh097UvrKvAJ117QYfwLyLJ5Bq3O4/wDqr3VhdhOgX0Ygj5
         rtHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCxqNuXyIFyIliw/A0U2VvnZaxwNUPOFvzUK/wwcbnAilCcERqymatGOJqy+tU1I2O0ukHN8K7qJKKMrKZpw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcLjrdKwd887P3KlOx+nxVkNmd3YEdxf3j1Kn4BQzWdfrSQy04
	AJk9//cBzRSjwclB67/2SIneSCpfhTmDREslIkSCTK1EAh32qJAczpqtMxD7vPX0x4h4kNY30h2
	z4a3tiQ==
X-Received: from pfbhc13.prod.google.com ([2002:a05:6a00:650d:b0:84f:4ff1:f767])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:985:b0:847:8be6:2177
 with SMTP id d2e1a72fcca58-84fb54f6116mr651351b3a.34.1786489085251; Tue, 11
 Aug 2026 15:58:05 -0700 (PDT)
Date: Tue, 11 Aug 2026 15:58:04 -0700
In-Reply-To: <27f2326dc66d6341174c0e510aa518a1297b66ae.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca> <anuAq2s4mtyw4_Ql@google.com>
 <CABgObfYR+vXBuSm3v5jbbZL8vF=XnocFAnjumdShgXBzod-HCQ@mail.gmail.com> <27f2326dc66d6341174c0e510aa518a1297b66ae.camel@infradead.org>
Message-ID: <anuo_OxfvJbQnn71@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, akpm@linux-foundation.org, 
	david@kernel.org, mhocko@suse.com, rostedt@goodmis.org, bigeasy@linutronix.de, 
	simona.vetter@ffwll.ch, jglisse@redhat.com, christian.koenig@amd.com, 
	paulmck@kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 22:21 +0200, Paolo Bonzini wrote:
> >=20
> > for_each_present_cpu(cpu)
> > =C2=A0=C2=A0=C2=A0 if (per_cpu(kvm_gpc_reader, cpu) =3D=3D gpc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpumask_set_cpu(cpu, gpc_rea=
ders);
> > __kvm_kick_many_cpus(cpus, wait);
>=20
>=20
> I'm literally sitting here watching you reinvent what SRCU already does.

The problem, for me at least, is that SRCU does this and a _lot_ more.

> Which, again, is *fine* given the behaviour of *these* read-side sections=
.

Well, yeah.  Why use a nailgun to put a nail into the wall to hang a pictur=
e
frame? (other than the indisputable fact that power tools are fun).  SRCU i=
s
fantastic infrastructure, but I genuinely think it's not the right fit here=
,
especially since we'll likely need a different solution for in-guest reader=
s
anyways.

> I get it. RCU is a versatile tool, and in *some* cases the *Sleepable*
> variant of RCU gets used in ways which would cause grace period latencies
> which are thoroughly unacceptable in an MMU notifier callback.
>=20
> But in the specific case of a dedicated kvm->gpc_srcu whose only
> readers are tiny snippets of code that until today were always run with
> rwlock_irqsave? That is *not* Jason's worst-case bugbear. It's fine.

I agree it's more than likely fine for your use case, I'm not convinced it'=
ll be
fine for use cases that heavily overcommit memory, or do NUMA balancing, or=
 (close
your eyes) enable KSM.

E.g. it doesn't take all that much for even a single expedited sync to gene=
rate
a delay of 20ms.
https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.com
