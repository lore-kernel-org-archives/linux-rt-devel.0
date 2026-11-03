Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793721151;
	b=iTOLGo7vK6cskaNi7JEMhReYVjAZpxpT73hkoFbHyL9D6hUNo3tUbftkAkyH3L7F1PeD
	 XzR1bgD3oMIy/gkGkKX+5l95apR79tI0MzpBxAeMYdoSnLaPemAuHekuUN5EmMvDu/a1n
	 2j+RTA6vVm6nHqXQbCBZV8qKajYJdYTtnjT5FCSD0v/GSutOrSGPOtVQ+kfjYMn+TwJTR
	 HendKmiY6GPar+x0xCT+ROEQy72ggAJ5NvAKpWqgmtSSaTYYUuC5fFGxBUlLJYug8WFnf
	 4hgawHQckyJd2PnfD2jHA7ylDP6oFCZrPA/N7KCrAnrTOzQh3QeDxKsTcTRCHt8O9vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cj3GedmPh7Cu6AsgVSUDiDu7DEi6SUzKXZt5ynjowoU=;
	b=O8+i8GU8b6LLXp5rGgaAUpQwjk+c3rAMDwpxVOV2j4ghhNvWHsJKEFPjPJ84MHMS2h/v
	 0g5EewGRMiD7+NyUGILZMSCh2CDjhb+zbi0LJDvRhpZZcRzCVC4cSWF8KW12MVSHO6vHA
	 fWQj80MC6ezu4OFRTqHCS+rNnoYtTYaSOSfV7PGzLe7HpeAO5XjXxAbRrzYT0pDZoI+T2
	 muLSWbOGIhPVzXOvBa9VnAO7pDa/ikPB/jxDUlC3jLjNVklDZDlhbNRbybAotZuf4gZco
	 g19zl9m9w32xLNGVfMt/18AFsgNeWFMkfQJu1QVGywZKa/koX1QKLv6R1FGZGju5xgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=NYrcBO0f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D0606A334
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 15:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149D0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=NYrcBO0f
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d885929so3490598f8f.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 07:52:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793721149; cv=none;
        d=google.com; s=arc-20260327;
        b=U7cu9VETRgCK9fbcKivVyqW74psYJqqvidQjlU8/v5vpCt3B6ia2Hg79xl3gPEj7+o
         2nqdxLnt6w1Az1EgJtJRDcZa9RUhU3HoMm+AI42euE4574BduH8qw8ViBI4ny3LheHxt
         CtM+qoHrve1/rfel2/xEGTIJM4jPHHLM+GJh78NP06WLUGCR+SwXMh/qW4xxjvLPJlva
         sH7AL7QNBgIYK16Ux9HPa3gVK/Dx0FEDzIaXsbNFwsfm3Mq7Fir8wQkoqQOHoYNWemJV
         rh6ChWOFUJ6FdKDtGQxjj7MdlvNiH7cHXb/pRHWAs/4BvSXFlLRKvVXEXOepfrfpo51T
         3oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cj3GedmPh7Cu6AsgVSUDiDu7DEi6SUzKXZt5ynjowoU=;
        fh=Vg0TBo+iVVjlqKfnr3eBe6B2feEit7w8b+zh8KLlh54=;
        b=PsmCY5TrtMH8k+cpjPNQZQxopaHg8INnNR5IipmSePARr2D4UWBVMlimP2vkW5EI8Z
         FsciP+YsTNs0y4fHrxTTVYmMOkSjSA7Xt/WaOigZadzYuLlqmaUdEDJGXYm9o5PzFh5W
         seNwXKX+D4TkfX93y+BbTVZNELNoVwsMPvFe+7anUyo5wmPJH5Mj2FlVl8Iw4A7faaql
         vAAOfXA1C4J+SnQ22J/+tnLKSevM93+IXVEnLTIx7Fuzb+01ae9/dbhELig8HqyilqKC
         N/6IuWS/Gd7rOfXhDx3chaoOL6L6QCKHuB/t7qLTUkw7rt3QCsV6hUul/Kmu6YPyZc0w
         zTcQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1793721149; x=1794325949; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cj3GedmPh7Cu6AsgVSUDiDu7DEi6SUzKXZt5ynjowoU=;
        b=NYrcBO0fFI/EsLYRDMpnfh12F1Um1kZ+JfPJ08jkKL/Zelk4VfSc6E3U9kP2QuVC4v
         b3y+kqfCEtdsgU5UTUW6K1xRg6I7wDL0G5OGvtog1uXmeOV21URrLPZOqsFqu0ZhjvhI
         3zQNdKcwqHjyWW2M2FYKMucTNveE35oW7ZSMEyRZzzzBhthObTA5RTn62+v/tKD6LSZk
         5hluR1cR2RTgFB1mDf9VjsX95yFVEbJcOVTze4voypaPN88xVBDFqHkTniN4w5C/zo+w
         c8eaMDEN6yKeYDw7+b417g2wjYfM9992tUtCmqe4LTsE3BEigx1o/rT9AF5AQOce76Yd
         ee3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721149; x=1794325949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj3GedmPh7Cu6AsgVSUDiDu7DEi6SUzKXZt5ynjowoU=;
        b=xomskG/zUDJFS8/VDM+SkENY5s/rsp2+S+7BDryX08xUzny/4X82EH/22a/OntWOur
         2fyDDX/TdyimJErXtNyMX/VO8AGlfmK6N+dId1MQzXiQVkvbwE30YvuwPoYdhlWUn6xr
         /Rr2II32hBhm6x3QSqqbim8FMFy0vYJmd/fiIDzV1vYzX2hFH99jzahdUF3lAsnx+pqa
         IbmfFohYIQrgShYIhR+7z77J0HSPdg7pu75BWV7ePgP4WTKoAH1Ctouj+++DVJmxX9Py
         rRZ9+wpyJ7572YwCXrDXM+EsUKE5+/jnFjx6D2IShOHrR51mQC38Gly80NIRI61c3FnO
         H5zA==
X-Forwarded-Encrypted: i=1; AKwUvBzj/FYGo7HeeH31FuyHmy5qA0VRaVpc1M4Mj5bqnZOF9lXOS1e0JQh7dPHFB/4HaU2cTHMFlHcVHU97+ph40g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8PFp4vdaAhSGPv/wuGgwyzpA4Bi1mTq/iotbjqx2n4fOZd8UVI
	YZN3X+M9KT2pAC+SncJegHz2oMAPYT2G7iDoMABaBvOvZJDkkcLqrHD4KXHCwopSmgNsXG1jDx0
	tGE3i40Ty54AX8hkNCzeb0QGmQZn7WQ63BINp/Fh5YA==
X-Gm-Gg: AYBFou106g0r/99V0HJkSuKFhpTzw4AgkpjnICOCzdJKYWPtELYcFKAsaVoQVmusMbi
	luDLpLkS1jlI+vgvKMw6eXwvG6neQjecwI93tMQqDs5rTGhoAKfPZ0GdIceHFucxJn5sRX3+U3t
	HtAzDPmQHVfZma7eL9fWf0lOgE5jSXcLpCD47/X09/eN1sxN7d/q/Xk0qTKxfHbtdhD+aNuYAB9
	OE3uFMrF7rCIH5c7Hg0s19UK/A5MVNfFCzvyfRTLB4JkJ4Tlc0iSGfKCitW6Y3alNPQ4hJg7cQZ
	ZfWJSdoicghpQ4ST9nHTIJMui6T4ZuFJlIeldj+NzdKxky8Z6oGNRVmgOghu+WiPi4l00pSIl2r
	2Hc4oCuXGQuTykNrfW0IBmYVTebPwbFBoWuQJ2lGNz8Tki33ud+L0Qw+1f2zuPXvVznzSOdf6+K
	r8HD4t40sfBGE9jS7bAzHgJPIIFXovyaou8fZvX7osAFSCE76+HyqfM9wh
X-Received: by 2002:a05:6000:4026:b0:48b:4a2:8175 with SMTP id
 ffacd0b85a97d-48e6e501911mr30600099f8f.43.1793721149190; Tue, 03 Nov 2026
 07:52:29 -0800 (PST)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
In-Reply-To: <20261103-imsic-remote-sync-irqwork-v1-1-8b5c951fc62a@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 3 Nov 2026 21:22:17 +0530
X-Gm-Features: AclHuK-Duz2U2kH9foWsdX6nwnK4quq9DLKbc6uMPaHmTR3hhx4HWy-1ofAnrKc
Message-ID: <CAAhSdy26R41W6OsTpEjMCf6iQXrtn4WrzziuGg+S9pHOHtM--A@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-imsic: Synchronize remote state with IRQ work
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 1:34=E2=80=AFPM Troy Mitchell <troy.mitchell@linux.d=
ev> wrote:
>
> Remote IMSIC state updates are deferred to a timer on the target CPU.
> If that CPU has stopped its local clockevent and is waiting for a
> broadcast interrupt, enabling the broadcast IRQ can depend on delivery
> of that same interrupt. This can stall timer delivery when the broadcast
> IRQ is unmasked or moved to another CPU, including during CPU hotplug.
>
> Queue hard IRQ work to synchronize remote state independently of timer
> delivery. Keep synchronous updates on the local CPU and the timer retry
> for an unfinished vector move. Hard IRQ work also avoids depending on a
> schedulable worker when PREEMPT_RT is enabled.

Using timer retry for local CPU and IRQ work queue for remote CPUs looks
strange. Why not use IRQ work queue even for local CPU ??

>
> Fixes: 21a8f8a0eb35 ("irqchip: Add RISC-V incoming MSI controller early d=
river")
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
> This was found while bringing up the SoC timer on SpacemiT K3 as a tick
> broadcast device.
>
> Without a real broadcast device, the tick code falls back to the hrtimer
> based broadcast, which keeps one CPU's local timer running. Once the SoC
> timer is registered it replaces the hrtimer broadcast, and every CPU may
> stop its local timer in idle.
>
> On K3 the SoC timer interrupt goes through APLIC in MSI mode to IMSIC.
> When the CPU owning it goes offline, the interrupt is moved to a CPU
> that may already be idle with its local timer stopped. IMSIC leaves the
> enable on the new target to a timer on that CPU, and that timer can only
> fire through the broadcast interrupt, which is not enabled yet. The
> system stalls.
>
> Tested on a K3 COM260 board by offlining the CPU owning the broadcast
> interrupt, and then each CPU in turn, under a timerfd load:
> - v7.4-rc1 with the SpacemiT SoC timer series and local timers forced
>   to stop in idle
> - a vendor 6.18 kernel with SBI cpuidle states that stop the local timer
>
> Both stall without this patch and pass with it.
> ---
>  drivers/irqchip/Kconfig                 |  1 +
>  drivers/irqchip/irq-riscv-imsic-state.c | 19 +++++++++++++------
>  drivers/irqchip/irq-riscv-imsic-state.h |  4 ++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 136bab41f801..5cdc3f52198c 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -651,6 +651,7 @@ config RISCV_IMSIC
>         bool
>         depends on RISCV
>         select IRQ_DOMAIN_HIERARCHY
> +       select IRQ_WORK if SMP
>         select GENERIC_IRQ_MATRIX_ALLOCATOR
>         select GENERIC_MSI_IRQ
>         select IRQ_MSI_LIB
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index 01620373b43a..f6373e4019a2 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -252,6 +252,11 @@ void imsic_local_delivery(bool enable)
>  }
>
>  #ifdef CONFIG_SMP
> +static void imsic_local_sync_work(struct irq_work *work)
> +{
> +       imsic_local_sync_all(false);
> +}
> +
>  static void imsic_local_timer_callback(struct timer_list *timer)
>  {
>         imsic_local_sync_all(false);
> @@ -268,18 +273,19 @@ static void __imsic_remote_sync(struct imsic_local_=
priv *lpriv, unsigned int cpu
>          */
>
>         /*
> -        * We schedule a timer on the target CPU if the target CPU is not
> -        * same as the current CPU. An offline CPU will unconditionally
> -        * synchronize IDs through imsic_starting_cpu() when the
> -        * CPU is brought up.
> +        * A remote CPU may have stopped its local timer and be waiting f=
or
> +        * the broadcast interrupt whose IMSIC state needs updating. Use =
an
> +        * IPI-backed work item so enabling that interrupt does not depen=
d on
> +        * its delivery. An offline CPU synchronizes IDs in imsic_startin=
g_cpu().
>          */
>         if (cpu_online(cpu)) {
>                 if (cpu =3D=3D smp_processor_id()) {
>                         if (__imsic_local_sync(lpriv))
>                                 return;
> +                       __imsic_local_timer_start(lpriv, cpu);
> +               } else {
> +                       irq_work_queue_on(&lpriv->sync_work, cpu);
>                 }
> -
> -               __imsic_local_timer_start(lpriv, cpu);
>         }
>  }
>  #else
> @@ -510,6 +516,7 @@ static int __init imsic_local_init(void)
>  #ifdef CONFIG_SMP
>                 /* Setup lazy timer for synchronization */
>                 timer_setup(&lpriv->timer, imsic_local_timer_callback, TI=
MER_PINNED);
> +               lpriv->sync_work =3D IRQ_WORK_INIT_HARD(imsic_local_sync_=
work);
>  #endif
>
>                 /* Allocate vector array */
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/ir=
q-riscv-imsic-state.h
> index 189829b8673a..a36b9f0ef840 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.h
> +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> @@ -9,6 +9,7 @@
>
>  #include <linux/irqchip/riscv-imsic.h>
>  #include <linux/irqdomain.h>
> +#include <linux/irq_work.h>
>  #include <linux/fwnode.h>
>  #include <linux/timer.h>
>
> @@ -34,6 +35,9 @@ struct imsic_local_priv {
>         unsigned long                           *dirty_bitmap;
>
>  #ifdef CONFIG_SMP
> +       /* Remote synchronization must not depend on a timer interrupt. *=
/
> +       struct irq_work                         sync_work;
> +
>         /* Local timer for synchronization */
>         struct timer_list                       timer;
>  #endif
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261103-imsic-remote-sync-irqwork-9cfec6c410de
>
> Best regards,
> --
> Troy Mitchell <troy.mitchell@linux.dev>
>

Regards,
Anup
