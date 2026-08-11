Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147037DEBF
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479703; cv=none; b=Cs5wHxPqdEFehfQROIpPk3737IiLq4xzPWWxnl2cfc8A9xkeSGyUshat1/Sgr0ofycEU3gduesLp/dKbLhrQlCKYNr/ktwIE9HlxE7ulG0HydkG1FZXjyvdC2OVGESuqXhl8qq/MbiqOVx+eKsx5I4yP2J6XKTZbac0T5/MLMgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479703; c=relaxed/simple;
	bh=or5I/jgV4DG+CHbwj9QFHKb5QkogaftlErhfi8b8BYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDHYzRYj5TebnlhCI9ByMfTOorsZqbGHKnTXa4GUQ78V0ALLBeSwOd3S/NDwtBDAg3YRf/EGtCGy/hz5DZBtXDpSzAvoR2l8Eq1N1s94+Zag/glcWhOvS2WWgJymaSGKiTVhOhCg+/kggFWo3sPQJI8hekvCW9HQGkdR3/Z30cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5Sn07vA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5Sn07vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786479701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
	b=P5Sn07vATsLCZPkxOaTxdJPn7MUhQkZVB/95DgXexhgkfJIcCPfzdyJxp6yKFzJS3COJvP
	rxAr1CszABtfSxFQ6j/q+oAASJQzpjqMY5sU4gFqL+QTi3GKthdGVLrzv403rz7lS5rxV7
	WmeMV6jy3RHjIl6wrUBHXahJG5uzYWM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-jFjnC3X2PTyetclclEKq-A-1; Tue, 11 Aug 2026 16:21:35 -0400
X-MC-Unique: jFjnC3X2PTyetclclEKq-A-1
X-Mimecast-MFC-AGG-ID: jFjnC3X2PTyetclclEKq-A_1786479694
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso99807f8f.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 13:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786479694; x=1787084494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bt1fxL8cERBCqsI9SSKDXDKzRvK6X8fCwUPGaC7m26c=;
        b=CjG6gYQd3gHYzwTQ1F6v8jjlnIWKZawYrT/5ajhx8EexVLmzTvFjLKpwqI7+WCyzbz
         D2xJT1xiONQ+2UCovxJ1B6yb8xC5ADEgMxm7vktWJpIFNHuuoaNTzr9vgDYfxNsZ7snY
         GpJzPHcNZ5Fb00yFVgAWb6z/43Jp6zjf7WmvybrVtBMkPor/Hgk73+NVOGEmpzc+nbwP
         qTTeax6rx6kImna//9GmfmDQBGeUAELTk0L3BanmXdnQlUcoVpD/Appd9NMMorbE6kOw
         roZyIVLW4vIA6HDea/Ww77zE2EQfFelagmelFbkeJxHjn7KwtDe30eqOdrH7aD7xGtUb
         +Ptg==
X-Forwarded-Encrypted: i=1; AHgh+RrwcMtveOyVuz9K50WNY1xhOquzTKUvVyMYPWpUzRObK9NYjPdVq2fj3RcOep0Ibn6YnPLZs28lh4pyOPH4LQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv9pxppOl6H8mBCQX4lJJm2Xke1b6uy4L6zQSzmZrbHrzXB5op
	3GpywAk5C0MBlvascQwJdE190RlZUz+RmPqLrjBlaXZMAOKuj+L85yHAXb6AqIkF/rjt/z4PfCZ
	2cfGjWWgtv2mABfgZCBUTPl5HdNU+8Yy4wnaAllEwpTIhfqKEVHqK15uaiCrbitKnEQtAtr4Lv0
	L9mma32zJSvrv8s3wCqlrOr/zitxD68h+xzj/xLWMsLhU=
X-Gm-Gg: AR+sD10Y3QV9B4JEAwcZE2OMavU/QMWYWAOcgJHJDCmhXjB6bFTNCO7urk/ReqC2HzO
	duH+8VcBcgTmU+rbV59mFNPiJYNypg2zFGdHAGGhwan70XRDL/nRi4LhuT6KU8koBWB3FNtM+Ux
	gN4AGSTGMkeUJemgmZcRnZazht0L0exDl7VMKxUlOpXug5/NEJ9p03Yn0va2U+XtpVtj9hDnxRp
	RFH4sF2qc2K03Kh/ADYLRYoVrhPKDatutvWTmmItLS362FDt539ErdIwq4=
X-Received: by 2002:a05:6000:4011:b0:47f:97bf:d891 with SMTP id ffacd0b85a97d-4814ad755d1mr8659624f8f.1.1786479693827;
        Tue, 11 Aug 2026 13:21:33 -0700 (PDT)
X-Received: by 2002:a05:6000:4011:b0:47f:97bf:d891 with SMTP id
 ffacd0b85a97d-4814ad755d1mr8659586f8f.1.1786479693441; Tue, 11 Aug 2026
 13:21:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca> <anuAq2s4mtyw4_Ql@google.com>
In-Reply-To: <anuAq2s4mtyw4_Ql@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Aug 2026 22:21:20 +0200
X-Gm-Features: AUfX_myRxh8LArbRwhhI2WDXN4cv5LNCX8fqVJeZG8bZ6cm6DTva5ox9mCkJIi0
Message-ID: <CABgObfYR+vXBuSm3v5jbbZL8vF=XnocFAnjumdShgXBzod-HCQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, akpm@linux-foundation.org, 
	david@kernel.org, mhocko@suse.com, rostedt@goodmis.org, bigeasy@linutronix.de, 
	simona.vetter@ffwll.ch, jglisse@redhat.com, christian.koenig@amd.com, 
	paulmck@kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cCnBg3PVaw8Wyk2zIrf3GqN5XMOu_ZSPJQOEl2Z4_3E_1786479694
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you want to avoid global contention on reads, you can trade it with
for_each_present_cpu().

On Tue, Aug 11, 2026 at 10:06=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> +static inline unsigned long kvm_gpc_read_begin(struct kvm *kvm)
> +{
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       cpumask_set_cpu(smp_processor_id(), kvm->gpc_readers);

per_cpu(kvm_gpc_reader, smp_processor_id()) =3D gpc;

> +}
> +
> +static inline void kvm_gpc_read_end(struct kvm *kvm, unsigned long flags=
)
> +{
> +       cpumask_clear_cpu(smp_processor_id(), kvm->gpc_readers);

per_cpu(kvm_gpc_reader, smp_processor_id()) =3D NULL;

> +       local_irq_restore(flags);
> +}

and then:

for_each_present_cpu(cpu)
    if (per_cpu(kvm_gpc_reader, cpu) =3D=3D gpc)
        cpumask_set_cpu(cpu, gpc_readers);
__kvm_kick_many_cpus(cpus, wait);

Alternatively, there's always the poor-man RCU using an rwlock_t; you
do read_lock/read_unlock as usual for begin/end of reads, while the
write side does

   write_lock(&kvm->gpc_readers);
   write_unlock(&kvm->gpc_readers);

in place of synchronize_src().

Paolo

