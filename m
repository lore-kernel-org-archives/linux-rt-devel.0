Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4163A5E8F
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Mar 2026 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880245; cv=none; b=sRmqbadGPkXw+2Tb42z8jT7NWYT8XUwvKT7KHBOJ0FFVpCYz7Is+yV+HLpeYhvdoCc1+WTZTMGDmBlXJDtSiizeUzrcjWAc0CVYwRrDg3Z5ja47Pg/Wj3b9j/6suvcVIo66Bn8MLxA2dF2m6uLOZfghb+CY4+SxCS7UbnwHusDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880245; c=relaxed/simple;
	bh=+3YqFSUNyQYBU/mexr8GetZGgBxQ0KtVyCbQx1UzE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ap+FoB1gc9FDpw64jVQgl5Xuee6JGgnFIVJHgrbnWvD+et+GSdV9Ik8qqacXUw4FN8o83QDHDQF598+IZ64AKtQmwY/ZeLu6Jjsf9w7shErwuz8B068q8hX2Vvw8Ro6cHCMBwvVLBIo7gzTEMZ6x4xrsP6s4KCXhLVn9sXuT1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B3AA913B3A1;
	Mon, 30 Mar 2026 14:17:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 497AB60010;
	Mon, 30 Mar 2026 14:17:19 +0000 (UTC)
Date: Mon, 30 Mar 2026 10:18:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "shaikh.kamal" <shaikhkamal2012@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>, Sean Christopherson <seanjc@google.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, skhan@linuxfoundation.org,
 me@brighamcampbell.com,
 syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on
 PREEMPT_RT
Message-ID: <20260330101814.7fa1e31e@gandalf.local.home>
In-Reply-To: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jusypfqta8af5arykfnknx3wxqqfg9mr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 497AB60010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/37p5S7H7cj6hq5M6HBXfYBah1YR90ibw=
X-HE-Tag: 1774880239-613610
X-HE-Meta: U2FsdGVkX19dTKXJsp3i5yBd8nAlNTBOZfmeQiL6bJ9nqPqBH1htcFDGdlqVP3+/gnUvEbNVnKicKOdfWpIAqPkYjap3SJVnsOHt9wUJT4WUpSO89zBEAjmdq6RJM8P8kb+GZl9cc+g3gT+S3IXKsi7BVW5ZzMlo5zjxdim4w6UzMJ0N8gygoV3soWRli5u530/6ZkNW1QwMVJPSj3/grOKqtK2XN96tB/9ijdmdudr9ORMHuKxQXbu/q88+2Gw/TUkub4+25LJ+bdwBeBkbVuYIlQMJVCafRXLYdM6f40GUko4yyq+vh/gQGpKOEEtqkVfCpHt6fjh/6CfEnsalu0eMcM8GXrhc

On Sun, 29 Mar 2026 18:45:43 +0530
"shaikh.kamal" <shaikhkamal2012@gmail.com> wrote:

> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -122,6 +122,24 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> +static void xen_timer_inject_irqwork(struct irq_work *work)
> +{
> +	struct kvm_vcpu_xen *xen = container_of(work, struct kvm_vcpu_xen,
> +						timer_inject_irqwork);
> +	struct kvm_vcpu *vcpu = container_of(xen, struct kvm_vcpu, arch.xen);
> +	struct kvm_xen_evtchn e;
> +	int rc;
> +
> +	e.vcpu_id = vcpu->vcpu_id;
> +	e.vcpu_idx = vcpu->vcpu_idx;
> +	e.port = vcpu->arch.xen.timer_virq;
> +	e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
> +
> +	rc = kvm_xen_set_evtchn_fast(&e, vcpu->kvm);
> +	if (rc != -EWOULDBLOCK)
> +		vcpu->arch.xen.timer_expires = 0;
> +}

Why duplicate this code and not simply make a static inline helper
function that is used in both places?

-- Steve


> +
>  static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
>  {
>  	struct kvm_vcpu *vcpu = container_of(timer, struct kvm_vcpu,
> @@ -132,6 +150,17 @@ static enum hrtimer_restart xen_timer_callback(struct hrtimer *timer)
>  	if (atomic_read(&vcpu->arch.xen.timer_pending))
>  		return HRTIMER_NORESTART;
>  
> +	/*
> +	 * On PREEMPT_RT, this callback runs in hard IRQ context where
> +	 * kvm_xen_set_evtchn_fast() cannot acquire sleeping locks
> +	 * (specifically gpc->lock). Defer to irq_work which runs in
> +	 * thread context on RT.
> +	 */
> +	if (in_hardirq()) {
> +		irq_work_queue(&vcpu->arch.xen.timer_inject_irqwork);
> +		return HRTIMER_NORESTART;
> +	}
> +
>  	e.vcpu_id = vcpu->vcpu_id;
>  	e.vcpu_idx = vcpu->vcpu_idx;
>  	e.port = vcpu->arch.xen.timer_virq;
