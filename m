Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82438236F
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303068; cv=none; b=KQvp7wVoO9bv/+mQAUFGFgcm9uZaf48oveUKXl5PP5Q6gF/gEzJ8RO7FQOAjueNO2l4bHGlBic758IE1YetRJOrmYTAZXflZw41u//qc6p98pyzfUB9HJvtgKRCk1gIy/W8CACml2vXlEYXz50zgEmR58t9jcwTjAEppp/4Zw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303068; c=relaxed/simple;
	bh=pOEYibe3mwsw1wifNGruL3Eh+txznin4GWEktrs9o/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtYfq5PPixtoLf/EFcwMU+r3o1+5hltYOsOKXd3tY1AHKmLLeuWoP1+GW/cquuCDaMpNwz3PT8j5Je0Ky/WSzwqpoz4o7PFf6nTnevL6cbH3i5jo2n4h3DTUlU5faiY5c6CUQ8wl1jz16+lbz3ilTeaIgabDVVioYHDbzFKJdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0wwxz1V; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0wwxz1V"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so518566a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 01 Sep 2026 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788303066; x=1788907866; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CyjsuaiM3cxUtm6fL7D4dZzUePgQ+dg4iTlfcvKm+Nk=;
        b=N0wwxz1VNmSjivpln2MYfj6u05+aoMtWQ3FNzTo/vk0A6SLyDCGTkjA/r7RvMqN0QB
         k6rYQoTTM43uoLhUm/k4KhZLeDj5z8N+GZjArrXRJe5+KFWw9/3dnZEDwr7ZVBeD9A/b
         3AO9w/oew6CO9E6bfZ/zQI2O4nVUL2DjiQILvZIGNSez6DN98RxnEKE69uT2Hv4a1yn5
         nmccII/s2iubhydaFxTvXKg7fC/OLXhBKAKyLa1sOWVm1b0tkqat0xDRh8RJKolsAb1M
         JryKF8M9CYpb7rsedBUpeSHGoouoUCpeX4XPxzUTT8aTJ02CDIMh3PzaRsg3jg/uif/w
         GYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303066; x=1788907866;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyjsuaiM3cxUtm6fL7D4dZzUePgQ+dg4iTlfcvKm+Nk=;
        b=UwUX4lfDOduxX1ePbHEBeAOCZAe2GiKgoAg9SkOaHaopXrDBMMcIA9y77YES0Gqyth
         p4rklFXrTlxRkIdHzXBiGCYdo8qnW90+OK7M5gZ296tL5saLXC/F5g5lBcM/UryjFH34
         fC+cr6512WrESCjcqCJVQl2qgwfjz49kwSaQ9pRP5/DuPK4Fgz8PVNmFPLgX6Oc5Cwyc
         qS0aJ0kkIarXvWYxU5YHMAoiK8vd/E5vkFrE0n1V+o/323SjkfBNnGW2+razibF/oSvp
         SGp5agitTqYfYnKQu0Xt0bjJnfcQ/LY8AQjDSQdB9U5o+oaJBnxTZsT+GhXijlcEGRf/
         z1OQ==
X-Forwarded-Encrypted: i=1; AKwUvBxvnWJGrF+GgZZx8Sxb0lEvjm6na453K8SE4Xs8Y02K50ACypD9Bp6Olv/gz1hAMJzrAb3fiAsRuTbVFKBYQA==@lists.linux.dev
X-Gm-Message-State: AFuF++m+E0ZMVavcNTreIuhzL4/9Ml8OHOvYusnZvhNWcRgHcnKFYgVb
	pTwf6s1JQZwDgnYsPjfx9FNG2GM8RgBtqP9uhn5kZXyJUK2lydAEmG8EBCud2DbFaNqqwKOshqh
	VAdhlVg==
X-Received: from plhd17.prod.google.com ([2002:a17:903:2311:b0:2d6:f308:c74a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b87:b0:2d8:d4d0:792f
 with SMTP id d9443c01a7336-2daec7571c1mr7978855ad.19.1788303065982; Tue, 01
 Sep 2026 15:51:05 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:51:05 -0700
In-Reply-To: <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop> <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop> <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
 <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop> <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
 <apcjs83XSU4Eb9hm@google.com> <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
Message-ID: <apdW2edsT_ZKfuUR@google.com>
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

On Tue, Sep 01, 2026, Paul E. McKenney wrote:
> On Tue, Sep 01, 2026 at 12:12:51PM -0700, Sean Christopherson wrote:
> > On Tue, Sep 01, 2026, David Woodhouse wrote:
> > > On Mon, 2026-08-31 at 17:58 -0700, Paul E. McKenney wrote:
> > > > On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> > > >=20
> > > >=20
> > > > > =C2=A0 * 23f10e07aba3 srcu: Add try_synchronize_srcu() for caller=
s which can prove readers absent
> > > >=20
> > > > I do not intend to provide a separate API for this given the possib=
ility
> > > > of indefinite postponement.
> > >=20
> > > Makes sense. In that case, calling it internally from the 'right'
> > > places becomes important, as the callers who care can't do so for
> > > themselves.
> > >=20
> > > We discussed the fact that synchronize_srcu_expedited() will also wan=
t
> > > to use the same fast path.
> > >=20
> > > I'm also looking back to Sean's call_srcu_expedited() patch from Marc=
h:
> > > https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.co=
m/
> > >=20
> > >=20
> > > | Due to differences in how VMMs manage guest devices, and in the
> > > | architecture being emulated by userspace, some updates trigger call=
_srcu()
> > > | with concurrent readers (i.e. while the VM is active), while others=
 occur
> > > | without readers, e.g. when configuring devices during a pre-boot se=
tup.
> > > | For the later case (no concurrent readers), using the vanilla call_=
srcu()
> > > | is problematic, as it can kick off a normal grace period (totally f=
ine for
> > > | freeing the object) and effectively transfer the non-expedited grac=
e period
> > > | to the upcoming synchronize_srcu_expedited().
> > >=20
> > > So the offending path uses call_srcu() and triggers a normal GP, whil=
e
> > > the victim calls synchronize_srcu_expedited() and gets stuck behind
> > > that non-expedited GP.
> > >=20
> > > Sean, if the victim is the "no concurrent readers" code path, as you
> > > said above, do you think the fast path in the victim should suffice,
> > > without the cost of an expedited GP for every bus registration?
> >=20
> > IIUC, you're asking if being able to use try_synchronize_srcu() for the=
 fast/happy
> > of synchronize_srcu_expedited() (i.e. for kvm_swap_active_memslots()())=
, even if
> > there's an in-flight GP, would suffice for a fix of the regression intr=
oduced by
> > commit 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_regis=
ter_dev()").
> >=20
> > If my understanding is correct, then yes, that should work, and presuma=
bly would
> > be a notable improvement overall.
>=20
> Then we could abandon synchronize_rcu_atomic()?  That would not be a
> bad thing from my perspective.
>=20
> Just to be sure, please note that synchronize_rcu_expedited() can and
> sometimes does sleep in order to avoid odd corner cases that could
> otherwise pointlessly monopolize a CPU.

I think one (or both) of us is confused.  I thought David was asking if we =
could
avoiding adding call_srcu_expedited(), because the proposed try_synchronize=
_srcu()
would fix a regression related to KVM's use of synchronize_srcu_expedited()=
.

I don't think that has anything to do with non-sleepable RCU?  Or is there =
a
separate discussion and/or implicitations I don't understand?
