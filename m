Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B412F7EE6
	for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926988; cv=none; b=QCKC/6QkSiTIckEVYgpJhdRwWX5Lm1YejCBM6kAmpM7q5UAY80GAruexSqhCFP0Joz17U7kxCDGKdA2UJ9786+DB2MYzAB64eOMLSvK7YfPUnY1cRyxQSt538rzBGOodRk14YoS/Jz7kFUvs9L6/U/aS4oVrwh016c1lcdM/g9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926988; c=relaxed/simple;
	bh=KN68LRoIM5aVi7AQOx7nnvGNWU1Z0eIPdG2ZcjuBWZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SJO117+lRuixT42gBHBZC9kBKI9tC1SMB4/94nf6LkWL9UkDYdzoGe2KA7m6Ha8Xol0cez1MsujhWpwIt+wTd2y4AP7jtm24PWrBV+r+Wgfjb5ihQIVepp6DRBc5KE6JWmoBsC/24VOKlC9/HL+uNi7hOPCt9jF+Y+JQ6hE7Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUQ6p6vM; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUQ6p6vM"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ce8a76df2dso18627925ad.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 28 Aug 2026 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787926985; x=1788531785; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uMXimE85N6j1kkWKNP1joCUzxKs1AFORqZCP5bF0HOI=;
        b=lUQ6p6vMacUCpp4s4M5TrrZtqhvw1a8c/ve6IJQu1dzCjcFT1DMKJPGMldDebTfpKo
         AZEWOikOXobYlvTQTG/VB2V+wlkW2VgsiLl47QYu6N+qNG0B8zPava0Y4yX/+GcTdzej
         8QhPmDyn2HFapzcb2XrnYNruiZ6MXla2PByXY+v3IHR7WR1JYFIBazMbDIBKKsVf7Qo+
         Npl6IHvkEpPWdmfY7Cx0xtKesDJyliiPpovSYBNsJY2ZYf6EJv+s/6ZX5s6BRm4+r22J
         XE4PaVbi2f94eEP/cRux1rPh78UnIJXU20qDILmLCPHcBwKPdOqAEhAGzdJymch96+ae
         aqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926985; x=1788531785;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uMXimE85N6j1kkWKNP1joCUzxKs1AFORqZCP5bF0HOI=;
        b=swaeeO7GTFcYoA1B8W2Jif1+rsYz6IRZUkqpUgfWEFp7h6Zrke8aSWaZJWfxWtefc/
         wV10JEnttdxAAPqOuZCKAgZor1YDXZyde1LGZbC+Z0h24g58I9yvqAss6iI2fg3U6roI
         mcPUcgOCRuc6DbdrlcVXSRXI0rMuCiYRHsLD92cNsr2j6GTrQREk9wma9nUMQ/DqO9st
         rmBP5WumjIMAdnxywHhZSHQyCLJBFZZsvO6c0IwzewmJ2EMG68wvO8ZxpkyNaItZ1y3Y
         g13pWx7bNQkVtnm+zwYmL+mLCWQ5f1VPFjMDMbjIZch5oPIneJNmjrAVoGOqo8On5Ag/
         RBDg==
X-Forwarded-Encrypted: i=1; AHgh+RoMPUXdLxhMBezL3kpWNKKC6Pdynfi+ybbGwnrfHH+FEUrO2Fgo0dgpvLXE1nNe5s446U5E0awnG71Ekk/dLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nBNBr/aZugiXCCIgiRH94ze35CV+l+j2QcWvpI5S4IZGRAE2Ko
	rbwh9tvtFzJBR/BaBiwBpHMlTuREJYrOhtM7u2cpTigioEnZ6bpxvKuZDi5CZXTzqKVfkoX15Wn
	Yb8ZL4w==
X-Received: from pgea25.prod.google.com ([2002:a05:6a02:5399:b0:c88:b675:3609])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9204:b0:3d3:aec2:4dc8
 with SMTP id adf61e73a8af0-3d3aec25083mr394376637.20.1787926984486; Fri, 28
 Aug 2026 07:23:04 -0700 (PDT)
Date: Fri, 28 Aug 2026 07:23:03 -0700
In-Reply-To: <33dfede6cca76de14ecffaaa92fd89da4114c94d.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <8d47b43e1829ac92703723e6a1a4afc7a2eaacb5.camel@infradead.org>
 <apCwV7xenDh2qmr7@google.com> <apC3lYri5r4KUM3T@google.com>
 <20260828104537.pXtV2G8D@linutronix.de> <33dfede6cca76de14ecffaaa92fd89da4114c94d.camel@infradead.org>
Message-ID: <apGZx3fhmzRl4Td2@google.com>
Subject: Re: KVM: x86/mmu: __kvm_rmap_lock() preemption assert trips on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, James Houghton <jthoughton@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026, David Woodhouse wrote:
> On Fri, 2026-08-28 at 12:45 +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-08-27 15:17:57 [-0700], Sean Christopherson wrote:
> > > > @@ -1745,11 +1754,15 @@ static bool kvm_rmap_age_gfn_range(struct k=
vm *kvm,
> > > > =C2=A0	gfn_t gfn;
> > > > =C2=A0	int level;
> > > > =C2=A0
> > > > +#ifdef CONFIG_PREEMPT_RT
> > > > +	guard(read_lock)(&kvm->mmu_lock);
> > > > +#endif
> > >=20
> > > And now I remember why I swept this under the rug.=C2=A0 This really =
should take
> > > mmu_lock for write, otherwise concurrent aging threads could theoreti=
cally get
> > > stuck competing for KVM_RMAP_LOCKED.=C2=A0 Which is silly, because th=
ey don't actually
> > > need to take a lock of any kind.=C2=A0 I.e. it's not super trivial?
> > >=20
> > > Wait, duh.=C2=A0 It is trivial if mmu_lock is held, because then KVM =
can operate on
> > > rmaps without any KVM_RMAP_LOCKED shenanigans.=C2=A0 I wouldn't test =
this because it
> > > might break horribly, but I think this?
> >=20
> > So you drop the bit spinlock and rely on kvm->mmu_lock instead?

Ya, it's basically a revert of the per-rmap locking, but just for PREEMPT_R=
T.

> > No sure why it should break horribly but it looks reasonable.

I wasn't worried about the locking, I was worried I was forgetting an rmap =
detail,
e.g. I almost forgot to update rmap_head->val in the "unlock" path.

> FWIW it survived the night in my GPC invalidation torture tests.

Awesome!  I'll throw a PREEMPT_RT kernel through the normal testing and hop=
efully
get a patch posted today.
