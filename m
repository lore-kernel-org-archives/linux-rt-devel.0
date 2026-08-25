Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023632ABCA
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Aug 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787687920; cv=none; b=Pdt98RewUztpMVZdeFahjJmJ3WWLLVpFmHtP4i2jqrGcq3h63nakYA8k+Pdok1pQkNVziJSDScQYyma0YpbKeRozXNyKxNPwKi+oJ0RdtUapdYLA3pMGNU1/IySi5TUdnOGuWgjDi02uB/OefiyB3GK29s9tsSOr0chDrQjhA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787687920; c=relaxed/simple;
	bh=Rs1ly7UYBMlUYE7QVy/j2KMt5Co5GBrj7F01YNt8mGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qA5E4xaZrKJBl5yIyr6WLklNlBAVzqCUeyfAMVO+gAzXOXQQfAo8+pgGHyobFN51ZvJhpP+BQXXOblf6e0If80kZVEsmcB+4yKaQnee7cNWazR1I4DKwxO6GtcVI2yimr4gY28PRlwMAIPOB7Ln9YZSkBqcDYcbPhiHwJqJ2c6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWkvC8Hm; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWkvC8Hm"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb6823efcso2363135ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 25 Aug 2026 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787687919; x=1788292719; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pw5HPga/49LaG41hAzsub+JW3+Qdxi0vmGANh8Af4Kg=;
        b=TWkvC8Hm1zX/7l/c/xGGWoo2n3c92pgrgtbwdlcr51Ok1VZoUtsvvgFmgSdB/kuBbq
         XaHfgHd9zYJyAdXwEq7OfSCKZUSHPyUL9OnCu9ZAunBlIuvnj8MjtmCXwwcyp5sfX/gi
         xE9D7ZhMdwHa2KJ+gaIAAyA6ggxE4eaeadMLhqkegil/pz2mi3LN9RzKurgIbVu2cl44
         FYxMc57RoMNNF3f5ZYUHYudY1Yyt/3LC62VF8TXwR1GJMWUo9tOm3nHU2AMqqdGmdpAa
         vMVlKRG9ALonyHnAuVWN2P+X01cvKJ2nCUpAPlqu/5OEC9wE1uXnNhmCJJeaQtdRLw+0
         bbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787687919; x=1788292719;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pw5HPga/49LaG41hAzsub+JW3+Qdxi0vmGANh8Af4Kg=;
        b=dmBF+whokoqokb/o6auZJHDbtzMF1DT1LYi0BUv2HVXxpmX360TvA0Ex5KGnAcYn/Z
         QL0Hav+SphWxVy1mDMrMEBBt9JTNpVc4ILyKUk9CROzZDv0lWwLpa4Da1qOiD0FSBOwI
         6CswHK+kTCZRo5laWGaAYu3zHlhL/5MncA/1Ot/EijHqlkJcccPsWPufhiPr+k5d7LY5
         Xvqh5NSP4Rx+YVhtYuH0DEXlp269Prrc8QZY9Pe2GM4cloR10PNx2+qoWXfAyJOGld0y
         4czyWRlnTnN7BISqbYwJevKUgKA299/Lz8gw8eSGjlV7hQtTq/0ODI8Q0XkbkbmNUe1C
         8Luw==
X-Forwarded-Encrypted: i=1; AHgh+Rp87UTpK0660E6ChaB0SDj3ZaQaSgRgWVJW6g0T3XABkEv5fMQP2WgEYTnEjcyUp7Jthiiw4BGSm+ZtQn6Saw==@lists.linux.dev
X-Gm-Message-State: AFuF++lKB9p7tV9ZNpmDYSYaotSWTvmlJ6yINckLLmyNnzS1S2hkF8ev
	kj4lAOl8gawP+/FKcI7Kg6I8iJzeHJyB2Wx5QkbbFzrpXkcJVcNeE/diO0vZL1mMZgkEY4R7JjZ
	uCpxKYQ==
X-Received: from plyw15.prod.google.com ([2002:a17:902:d70f:b0:2cc:6206:58ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ce:b0:2d6:f6ba:263d
 with SMTP id d9443c01a7336-2d707aafd1fmr12835735ad.7.1787687918385; Tue, 25
 Aug 2026 12:58:38 -0700 (PDT)
Date: Tue, 25 Aug 2026 12:58:37 -0700
In-Reply-To: <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop> <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
Message-ID: <ao3z7Rtw2FROkVpy@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Jerome Glisse <jglisse@redhat.com>, Christian Koenig <christian.koenig@amd.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, Paul E. McKenney wrote:
> On Tue, Aug 25, 2026 at 06:48:08PM +0100, David Woodhouse wrote:
> > On Tue, 2026-08-25 at 10:19 -0700, Paul E. McKenney wrote:
> > > On Tue, Aug 25, 2026 at 06:05:54PM +0100, David Woodhouse wrote:
> > > > On Tue, 2026-08-25 at 09:47 -0700, Paul E. McKenney wrote:
> > > > >=20
> > > > > On the tail latencies...
> > > > >=20
> > > > > The easiest way to reduce them is to require that preemption be d=
isabled
> > > > > across srcu_read_lock_atomic()/srcu_read_unlock_atomic() regions =
and
> > > > > across all calls to synchronize_srcu_atomic().=C2=A0 Without that=
, the problem
> > > > > is that the scheduler does not know that the spinning is pointles=
s,
> > > > > and we cannot use the blocking primitives that we could otherwise=
 use
> > > > > to tell it what is going on.
> > > > >=20
> > > > > So, is it feasible to simply require preemption be disabled as ca=
lled
> > > > > out above?
> > > >=20
> > > > I'd experimented with disabling it around the GP driver loop in
> > > > synchronize_srcu_atomic() as seen in
> > > > https://git.infradead.org/?p=3Dusers/dwmw2/linux.git;a=3Dcommitdiff=
;h=3D07165e79340e
> > > > and that didn't seem to change anything (which seems reasonable, as
> > > > it's the *waiters* that were descheduled, not the threads driving t=
he
> > > > actual GP). So your suggestion that we do it around the whole funct=
ion
> > > > certainly makes sense too. I'll test it.
> > > >=20
> > > > I do wonder if we're really doing the right thing here by selfishly
> > > > blocking preemption because we want a specific tail latency to rema=
in
> > > > low in a contended system. Maybe we should allow preemption and tru=
st
> > > > that the right thing will happen?

In my experience, preempting MMU operations, especially mmu_notifier invali=
dations,
is rarely a good idea.  E.g. see commit d02c357e5bfa ("KVM: x86/mmu: Retry =
fault
before acquiring mmu_lock if mapping is changing"), which worked around an =
issue
where KVM would drop mmu_lock and yield in an mmu_notifier callback on pree=
mptible
kernels.  We "fixed" the issue by avoiding mmu_lock contention, because it =
was the
easiest fix and benefited all setups, but the underlying problem that made =
us take
action was very specifically yielding mmu_lock on preemptible kernels.

This isn't exactly the same, but it sounds quite similar: being greedy and =
hogging
the CPU to complete an operation can actually be beneficial for overall thr=
oughput,
not just for the immediate operation's latency, by avoiding trash and overh=
ead that
is incurred as a result of yielding or being preempted.

> > > > Maybe the p100 isn't the right benchmark to be chasing... I'm looki=
ng
> > > > at it because Sean expressed concerns about it, but it's not the on=
ly
> > > > consideration.
> > >=20
> > > My concern is algorithmic, not benchmark optimization.
> > >=20
> > > Suppose that there is only one CPU, or, alternatively, that one of th=
e
> > > atomic SRCU readers is pinned to the same CPU occupied by the (higher
> > > priority) task running synchronize_srcu_atomic().=C2=A0 In this case,=
 the
> > > call to synchronize_srcu_atomic() uselessly burns CPU time until its
> > > priority decays, real-time throttling kicks in, or in some configurat=
ions,
> > > maybe never.
> >=20
> > I certainly have no problem with a blanket preempt_disable() around
> > both sides for algorithmic reasons. As long as we aren't *just* doing
> > it for the selfish reasons I described.=20
>=20
> Suppose I simply disable preemption in srcu_read_lock_atomic(),
> enable it in srcu_read_unlock_atomic(), and disable it internally to
> synchronize_srcu_atomic()?  It might be against all RCU tradition,
> but might also be easier to use.  ;-)
>=20
> > > Requiring preemption be disabled across both the atomic SRCU readers
> > > and the synchronize_srcu_atomic() avoids this, at least when running =
on
> > > bare metal.=C2=A0 My (perhaps naive) hope is that guest OSes get some=
 use
> > > out of those cpu_relax() calls.
> >=20
> > Yeah, an overcommited guest vCPU should be able to get preempted there
> > by the hypervisor, allowing other vCPUs to run.
>=20
> Whew!!!  ;-)

Ya, and on KVM x86 at least, cpu_relax() =3D> PAUSE will conditionally trig=
ger a
VM-Exit after enough spins that causes KVM-the-host to try to yield the vCP=
U to
another vCPU in the same VM.  The intended use case is to detect when a vCP=
U is
spinning waiting for a lock, to try and give cycles to the vCPU that is hol=
ding
said lock.  IIUC, the same principle should apply here.
