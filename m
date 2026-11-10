Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341994;
	b=HB67mbQzenZnC2zHy9jBkJpPe1m7AFBvzBR5Rb4nz3aGbQdtlBHFoi8yTWIzfzhrPLUR
	 r3eXTmFDsiEag4kVblnnCn1l5DC7Xl3ZAfYvLX5655Q6i18cfCM669QWucpCbHzJzcR5c
	 ws43xIzikOPD1rH+D6kmh/X+wA4gZBuo5yqhlgP3saC/gpEjFryqS2IbtfpUJwwpSG0BP
	 rwDytLxSf5sGpxgorYZGP+0IO9soc1nfNglOioxhex8cFfWNJCDP1vnRYrWieSWU/RAWn
	 eeuay+ImNxLuspsT9Y9/MX8U8WuJSVOVuIbA2/pgTVbM3o7eJffFi8u6aok9IHusGXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
	b=5o7usFW0qdRHL2pgYqhyQevTEj1WJfb8zKY1stDC5uZfzUdSHgXLArTUN4tsDZ9m8ehu
	 AWI3cwxU2A/v0Q/PexExHwnG1qrVoe7wYMFDiU4mKKq9DZ5Q0h6TeGRkcVIK6PE/ZeTOH
	 dt+rdBpwWjT/rwS3p7Oivvsaaymhu4QM+aC5hMOECUVqEP43oKmaMZObpRt2HHr0u5Rdr
	 5+ckIXSy3qOrv9hocloCEJUFVjPLldstvKpdscFwDI8Y2zdgOGRqrt24SEUI6JJQktcl3
	 NPQIlJJvh+bh6lRzEJebU4pnu8TcNj6aA6Ug+MtQ1BUUq8xm9583K0Vf4ebQyqTgufQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EOxxigw8;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51D606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 20:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A51D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EOxxigw8
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdd77f53db5so1275211a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 12:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794341994; x=1794946794; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=EOxxigw8jCDPoaYicc3KBFn3psS0r8alYoNCj/NqZCCVteRlMMEQWW8efu7cJiKqM+
         n6oa5rSG3JOkzRtz28bZbDvU/jS/LJnUyZro0aI8JfH547ohaPCn+bDLLnmKL/dYRpye
         /hlAvYoxlfsNukWcgMndNvyv/D9dJHO+TxObfgrBEnJsPLG7hAscDYpMNLU343Gu+ZWu
         mIMBH9pkFX3FMPdP3BFvTBUunPHxZLhq+n8LmYkEwup0HQQJl3ayZU/JJm309zd9mz6M
         X+wr4OuZRhYZ9yFRa9/hZUNcqPCXhouF54XEV6PDAqJ0vzkdOeSlywhvxztoYevZI5Ku
         sXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341994; x=1794946794;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sA+c0y1gtg/3n5Y+gL1JpZOKDFrA6DPjieeMuAQE0Nw=;
        b=q8p00giLJbeapLU7EJFpsXNRDScCEfNc0Fguy4GUZRVjmmBt2PwRP9sbb25UShjKl1
         O7FdeB32F6PiGh7v7ieO6BSOJYLqfRgNUyA7PHhi4CU5GWANEVFEwS91C2kBrtCMW3Au
         COY9HHGjRKUrIbzNjD58H9JrGN5ut1Kora0ONTIm41KLddjfNWfHK4q0Xl70TB8TS23c
         MHMXU0hq9U+3qoQVJJsjFKO8dlCRj3b65AqSHjuDQjjTvfuiOcBiEMxhVy7OqlpoCt25
         yztawhlxoP5sFlOH5IVoomJM3nocoGrN8HUT47g6DZnWRcdoxMjYVvPD7zrkVilLsV3C
         4/ig==
X-Forwarded-Encrypted: i=1; AL+hErE4Sa076+/vWiU/ABeD1Qz7bSYNU6oXEIypkDwEpJa3b3cub94UfolKLtBTcyho6kiVKiZ/jUR2vgUBNwA4PA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8CLqMVbUM5RyeeOizAi3dGn9KkhKte7CGlrGsGFwcZRH7k9nK
	SX287gqlx4e8CyOQsULYNlCML3UUR8Rjg4iwHQaKL+zt1sVZTNsBwEy9VkeQzzwgeSzrPgxOH5u
	gwHrVwQ==
X-Received: from pghf7.prod.google.com ([2002:a63:e307:0:b0:cd7:f985:396d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1446:b0:3e2:a849:64c5
 with SMTP id adf61e73a8af0-3f2fc99f9aamr241125637.19.1794341993521; Tue, 10
 Nov 2026 12:19:53 -0800 (PST)
Date: Tue, 10 Nov 2026 12:19:52 -0800
In-Reply-To: <20261105020104.2507083-7-dwmw2@infradead.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261105020104.2507083-1-dwmw2@infradead.org> <20261105020104.2507083-7-dwmw2@infradead.org>
Message-ID: <avN8aJIHiX4xyTNO@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 06/20] KVM: x86: Request the guest TLB flush from record_steal_time()
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, rcu@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>, 
	Paul Durrant <paul@xen.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Fred Griffoul <fgriffo@amazon.co.uk>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Kunwu Chan <kunwu.chan@linux.dev>, 
	Kunwu Chan <kunwu.chan@gmail.com>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
>=20
> record_steal_time() performs a TLB flush on the guest's behalf when the
> guest sets KVM_VCPU_FLUSH_TLB. With shadow paging,
> kvm_vcpu_flush_tlb_guest() ends up in mmu_sync_children(), which can
> reschedule via cond_resched_rwlock_write(). That is why the flush
> currently sits between a user_access_end() and a fresh
> user_access_begin(): it cannot be done while the guest page is mapped
> for access.
>=20
> Raise KVM_REQ_TLB_FLUSH_GUEST instead of flushing inline, and move the
> processing of KVM_REQ_STEAL_UPDATE ahead of where the TLB flush requests
> are serviced in vcpu_enter_guest() so that the flush still happens before
> the vCPU enters the guest. There is no requirement for it to complete any
> earlier than that.
>=20
> kvm_make_request() on the vCPU which is running is nothing more than a
> barrier and a set_bit(), so unlike the flush itself it can be done from
> any context =E2=80=94 which lets the surrounding access be simplified lat=
er.
>=20
> Note that the xchg() must stay where it is: it atomically consumes any
> KVM_VCPU_FLUSH_TLB which the guest has set, as required by commit
> b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed")=
.
>=20
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260530061932.7849D1F00893@smtp.kern=
el.org
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 6a1f0404f029..3c26c0eb9865 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2117,8 +2117,22 @@ static void record_steal_time(struct kvm_vcpu *vcp=
u)
> =20
>  		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
> +		/*
> +		 * Request the flush instead of performing it inline. With
> +		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule
> +		 * (via mmu_sync_children()), so it could not be called while
> +		 * the user access above was open. Requesting is just a bit
> +		 * set on the running vCPU, and the request is serviced
> +		 * before the vCPU enters the guest; nothing requires the
> +		 * flush to have completed any earlier than that.

Argh, I completely forgot about this.  It throws a big wrench in my plans t=
o fix
a mishandled TLB flush without using a deferred mechanism[1].  I really don=
't like
having to re-introduce deferred flags, but the diff is a lot smaller[2].  O=
n the
other hand, I still don't like the idea of delaying the MMU sync until the =
nested
VM-Exit.

I think I'll see how gross it is to do something like add a KVM_REQ_PV_TLB_=
FLUSH.

[1] https://lore.kernel.org/all/au0R41xbEJ_9W_9z@google.com
[2] https://lore.kernel.org/all/auDkX94UTjrLNmqp@google.com
