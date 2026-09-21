Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4448B385
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990178; cv=none; b=nghOW82Wkg5s+B12Th8bO+TMoi0j4b6zah7dgABn12YQ9GeBxzhMBamkM9yVUexBL0WBGsSV1/B7RtPIOZmjbB76Na4VNKwJ2QVPYH0H0tV2cpT3Tg+E/z0+6VfCQBX50BTLTgqwB4I+H24IckcpvqfPtZLR1usW/S+4MOnjnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990178; c=relaxed/simple;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaXs9uMB5T+CIzSYGGD/NFsuwfhcqpuzDMKbj6C+icY9a+z0Q9oz0XswQBRHLzyK3anXCXfT/0ZbXqcOKFPa2b2f7O7J+OWH3AvFeCaGpuAs5ABMuHgGjlVpK11zorVX73VrDzNOzp3swONBJDFWiWbt/v4020SBrz6oa+tBAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6ageLli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6ageLli"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789990175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
	b=O6ageLlihfDB6076/yHJyZKSoLL3nKRi/zQLTHfzt81mczUIQ9IS0tgvRJ1NlCjqBb4DoF
	GZrYoV3RbM1da3b462HvAx/mn3gZn/RrTsYJoZiIFO2UQUxFL/1TZPIy0U7ZqqGb/oJSYY
	phAiGePIBp/H+zTMNVR59vJJTguhh7A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-ZfcrVUBXNIKWpDvaAioWCw-1; Mon, 21 Sep 2026 07:29:34 -0400
X-MC-Unique: ZfcrVUBXNIKWpDvaAioWCw-1
X-Mimecast-MFC-AGG-ID: ZfcrVUBXNIKWpDvaAioWCw_1789990173
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f3c0d896so1665432f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 04:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990173; x=1790594973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptOPvpl8Jn4/467WKDIfcKUlrqRNuCJaQOy7TpWYDfM=;
        b=a9023R/aclAasU65AHD7yilJwQ0nzq1koSdS18NNjoGkADfYFbAHPjQxcZsOTY6KBB
         gBmolt6GENp+nD8Q4b1F5FTKeW3BAW6zZ6W5twkFE4iRn1vzQ2g7bF+NPfqaIBSo5eQm
         eLoOAPmUKoAk1TMzfA5/sksGdBYc4+FjqkCGT9Cqbd+gFEYjkhquTEuZea5KQjb6tceW
         Tr5dyeXRQcGSHWSxt0szIkUh0wQ2XXGvsLuFhhl28icGECp6/b1fEcQFaxKrI3HxmpA/
         Ncpns9i5kcFkkED/16nEd+0lWuIhOAbFn1MLREWbjthpzJj2RR92rqmDuc/Q45vPmFt/
         Wb0g==
X-Forwarded-Encrypted: i=1; AKwUvBxJ8DyoDXveH7O39z+RuL8QgwzbYp2yGN88AF58AiLDrSNHIy5RyBTIZ77AgzhrGkaGLuJoBFV75lYpNu+eLg==@lists.linux.dev
X-Gm-Message-State: AFuF++nkix1wINl9V0qmLDWoc+i8fYd0XYda2BVPr3VeVz4xIlgH+4Ku
	OCClNRRc642LQhi276HaQ99gDHjCSbpV3KUDgH6g2k3nXzhcccGgIQHTwppzozjtjTbIEF6JhMt
	tg5fuKlm/Ydh6ggZOo7mj+3L/IEqrWf52j/ga4vjxA7PD29EfTJia48SvYRrmEfEYuA+tbNVfEn
	XmwyqIAWyEUlUqTfMUC6RfSN7vwD4CcAQfhVtwA+JZvYBMQvyfq4o=
X-Gm-Gg: AYBFou3vztZYjjeAOXDpCIdJmDnm4/dqxjVoikKwgDPlxEipNyzTIHUOnfxt9Ns4Eyp
	Wztpqx1/rqPGVyXpBBPe0iugGnwNU2XUCWZmAEY3oJX2eROO97TOcfWlPKJAMFuR/Pb6HmF0+2f
	vt7IUmAsE61eIpBqvJlOnO+Tr3wcuds5RfNNTl6n4jOquSODMSC6n/8++DNJewfVj/T/sfyCGhw
	+DVKa8SvEAA12Rqu7bRUmR3zXArYDEzXaUNKdAWSQ3Rcgc7PDHa++CGQc9Srg==
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id ffacd0b85a97d-4871e373189mr14673927f8f.53.1789990172840;
        Mon, 21 Sep 2026 04:29:32 -0700 (PDT)
X-Received: by 2002:a05:6000:491e:b0:487:84:96d7 with SMTP id
 ffacd0b85a97d-4871e373189mr14673903f8f.53.1789990172510; Mon, 21 Sep 2026
 04:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <272c0fdf9e5eb9a1caf6a5c0bf674e3c006ac2ea.camel@infradead.org> <20260921112131.274-1-hdanton@sina.com>
In-Reply-To: <20260921112131.274-1-hdanton@sina.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2026 13:29:21 +0200
X-Gm-Features: AcwNN1Xi_H7uo3XvFAj5sLWKjk7Urm5G8ShkD2xSWIid9H62cmytfHb-xU95uPA
Message-ID: <CABgObfYZKfSV=Ykmjkey+t1pA4rEEk8=a-VMho4=A0=xNLmKcA@mail.gmail.com>
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead
 of a rwlock
To: Hillf Danton <hdanton@sina.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3jHpWuJmMZQw4H1HO0_2UO6D1jdujeS7gcTuJcKFUrA_1789990173
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 1:21=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 21 Sep 2026 11:54:36 +0200 David Woodhouse wrote:
> > On Mon, 2026-09-21 at 09:42 +0800, Hillf Danton wrote:
> > > On Sun, 20 Sep 2026 21:49:29 +0100 David Woodhouse wrote:
> > > >
> > > > Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
> > > > domain (kvm->gpc_srcu) for the read side. Readers now run under
> > > > srcu_read_lock_atomic() alone =E2=80=94 preemption disabled and non=
-blocking
> > > > enforced, which every GPC read-side section already satisfied as a
> > > > former rwlock critical section. It works in any context
> > > > (including hardirq and sched-out paths) and never fails or spins,
> > > > eliminating the
> > > > read_trylock() contortions in the atomic paths, the double-lock dan=
ce
> > > > with the lockdep subclass hack in the runstate update, and the
> > > > PREEMPT_RT problems inherent to taking an rwlock in those contexts.
> > > > In particular, kvm_xen_set_evtchn_fast() is called from hardirq
> > > > context (timer callback, kvm_arch_set_irq_inatomic()), where taking
> > > > gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.
> > >
> > > Given the preempt_disable() in srcu_read_lock_atomic(), as PREEMPT_RT
> > > has no way of handling preempt_disable(), you need to add another
> > > version of srcu_read_lock_atomic() with preempt_disable() replaced wi=
th
> > > something like rcu_read_lock().
> >
> > Hm? What's wrong with preempt_disable()? It works OK, but is generally
>
> How is preempt_disable() handled by RT?

It disables preemption. :)

The difference is that *spinlocks* (by virtue of becoming sleeping
locks) do not disable it, but the low-level primitives preempt_disable
and get_cpu do not change their behavior.

Older PREEMPT_RT patches had get_cpu_light() which did
migrate_disable() instead of preempt_disable(), but then
migrate_disable() was deprecated.

Paolo

