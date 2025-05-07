Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E8128C859;
	Wed,  7 May 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626640; cv=none; b=jbKfm8tQJ8UsAA0Us3ckN8SotcExIYPtrJn4U4HOF2ZO8a+aSCLY2jixzRrNyPPdeekHyI6w0ACGDCe3FDXJ7+DFbpkinYqVgL/AqejbwH93mhgUq8ukRz2W8x0wK3xv8HbHuQByT31I8Tpm/DHOtekbeo42L9Kjhs8Jn2N9d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626640; c=relaxed/simple;
	bh=cPAiWqaxzmrEcflp3jNSxIq1z1vYc2M/r9eccZySA2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tta25MTgjgfdKWL8/3W+Ga5ij4rmG8BR4GzF7D2Nn6WPMx+K4oxJ+inoVat2dvcQwjz1tbTPoDedGQFKRL2rxhKnbpWwzp0IURW5+rAqqhcOAZAlqr/QAa+s58EjdFp2hHORgQNy4aD7Zu4MI/ydeIltp1dNJ5dNQKvrZkl8ylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtxnFrYz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtxnFrYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C91C4CEE2;
	Wed,  7 May 2025 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626640;
	bh=cPAiWqaxzmrEcflp3jNSxIq1z1vYc2M/r9eccZySA2o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NtxnFrYzH/TQD41otaORYFAx+WcD1glvVrwP04w+XUu33kEL2xDy5fDa1FKIfnDFJ
	 nE1EebkgoEfMnrrgnaK3l7Vn7EtSu9mP0l/3bfpvdZ0hKq5BGwlT08Wjh0vzsP5C6Z
	 8l2JXpRorw8L0miaC6TlzCqz35V6lJSpEWqrtmrzx9JXD0aDuvkJt5LjyLUllmX+3o
	 AcYRx+TOYnzTD7fu7mUdkS1e6CExFhKb5vj9+5t6Itf/1zlr1G+nwi8dxfCr6Apet9
	 QTTdNH/3JBXkSvApLabnH4Ccq4RqNOyfjUTRrXZX3NIIBDnaTC+kwOEhSwK7BEv0Pu
	 QR/BBoyRZsoNw==
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4713857f8f.0;
        Wed, 07 May 2025 07:04:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDi5BMvkvuBcu1FEL1rQoAckNakdq186AwO5Al7gOH5mR4kOZ8RHqB2RpFYnZEMl7J/xHtf0xkryJqjxZX/g==@lists.linux.dev, AJvYcCXjm41S2z/Jep5ZDM+TDg0h+XCq0OS76XHNvplGbnk49Z4Ygjq8bKAFzDLx/pFwvtX2u96vKId8cLbG@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+bi3co+Zo+7v9mwpPnsGUtzFFF/vF6NriZSPkhmV1eLCSQFF1
	qnBuNlXxkgEgLCoszDyDKDkGG4wi15uUN7geMRUgZBtM8BikOfD6Jtm0lBj3hfBmE9aEcdNlLP3
	dG8SXKzWckbOec5C26cFLsJSWEdc=
X-Google-Smtp-Source: AGHT+IGeZURpUcczy0dcfIEPPTUD5WpzPzvDAVjDBUov0uWFAtMzcSVCJS9AfYe5zVbjUedAsJhdILw4cDvOJkMaABI=
X-Received: by 2002:a05:6000:3107:b0:3a0:83b5:f4c1 with SMTP id
 ffacd0b85a97d-3a0b49ac3ebmr2747534f8f.24.1746626638548; Wed, 07 May 2025
 07:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250507100624.8925-1-zhangtianyang@loongson.cn>
In-Reply-To: <20250507100624.8925-1-zhangtianyang@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 7 May 2025 22:03:47 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+kb4xiiSanFpx=xfyOuCxi5AdyF5cJ8rV9vm7UEBJPg@mail.gmail.com>
X-Gm-Features: ATxdqUGiJi4oX7jknYaNLqIq09DM6zJU6qZXSErH6DXge3UDYwR023AWCnRtThE
Message-ID: <CAAhV-H5+kb4xiiSanFpx=xfyOuCxi5AdyF5cJ8rV9vm7UEBJPg@mail.gmail.com>
Subject: Re: [PATCH] Loongarch:Prevent cond_resched occurring within kernel-fpu
To: Tianyang Zhang <zhangtianyang@loongson.cn>
Cc: kernel@xen0n.name, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	rostedt@goodmis.org, loongarch@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tianyang,

LoongArch is not Loongarch in the title.

On Wed, May 7, 2025 at 6:06=E2=80=AFPM Tianyang Zhang <zhangtianyang@loongs=
on.cn> wrote:
>
> When CONFIG_PREEMPT_COUNT is not configured, preempt_disable/preempt_enab=
le
> merely acts as a barrier. However, cond_resched can still trigger a
> context switch and modify the EUEN, resulting in do_fpu being activated
> within kernel-fpu critical section, as demonstrated in the following path=
:
>
> dcn32_calculate_wm_and_dlg
>     DC_FP_START
>         dcn32_calculate_wm_and_dlg_fpu
>             dcn32_find_dummy_latency_index_for_fw_based_mclk_switch
>                 dcn32_internal_validate_bw
>                     dcn32_enable_phantom_stream
>                         dc_create_stream_for_sink
>                            kzalloc(GFP_KERNEL)
>                                 __kmem_cache_alloc_node
>                                     __cond_resched
>     DC_FP_END
>
> This patch is similar to d02198550423a0b695e7a24ec77153209ad45b09
> (x86/fpu: Improve crypto performance by making kernel-mode FPU reliably
> usablein softirqs),to avoids the issue, and extends kernel-fpu applicatio=
n
> scenarios to softirq.
>

You need to Cc the stable list here.

> Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
> ---
>  arch/loongarch/kernel/kfpu.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/kfpu.c b/arch/loongarch/kernel/kfpu.c
> index ec5b28e570c9..e60bbaca357a 100644
> --- a/arch/loongarch/kernel/kfpu.c
> +++ b/arch/loongarch/kernel/kfpu.c
> @@ -18,11 +18,28 @@ static unsigned int euen_mask =3D CSR_EUEN_FPEN;
>  static DEFINE_PER_CPU(bool, in_kernel_fpu);
>  static DEFINE_PER_CPU(unsigned int, euen_current);
>
> +static inline void fpu_lock(void)
The x86 naming, fpregs_lock() is better than fpu_lock(), we can keep the sa=
me.

To save time, I have fixed them [1], you can fetch it to send V2.
[1] https://github.com/chenhuacai/linux/commit/fa0952bb7667b138a8941bb3e867=
75adc9f4731f

Huacai

> +{
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +               local_bh_disable();
> +       else
> +               preempt_disable();
> +}
> +
> +static inline void fpu_unlock(void)
> +{
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +               local_bh_enable();
> +       else
> +               preempt_enable();
> +}
> +
>  void kernel_fpu_begin(void)
>  {
>         unsigned int *euen_curr;
>
> -       preempt_disable();
> +       if (!irqs_disabled())
> +               fpu_lock();
>
>         WARN_ON(this_cpu_read(in_kernel_fpu));
>
> @@ -73,7 +90,8 @@ void kernel_fpu_end(void)
>
>         this_cpu_write(in_kernel_fpu, false);
>
> -       preempt_enable();
> +       if (!irqs_disabled())
> +               fpu_unlock();
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_end);
>
> --
> 2.20.1
>
