Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A150426EAB
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 May 2026 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518270; cv=none; b=KlUFtx0Qc4+rQzJ+yuBq8FTStkojhElj4Fpy9bLgLqwhVWCxER9kt1P9cj2M4Ft0loqCvuJbQPQx9qstcGixMddHSaxmz88RYrf5OzwYEJfq6Gu+KjZYOkifhxW4wRpXFqh0g32c/mYAlKhwRxhUBn+8ixy351Xzd3PM0Rowe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518270; c=relaxed/simple;
	bh=3X4xRBr2112PvEE0OwmnbAt2eKpuQ6Uuwxlk0Ytyvf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mv/Bcy/jGg9Ul/WvD7TBV9pQE/6gvEkp3HrG4GrqN58WBuuMrUTAKGnOu3x/J0jubLCballJiqbICkfoFRm2/7BFXqSgSaZoN4cualRRWSmtWUuXztXw/7x4cbU2WMZ++w0oYx3H5DaFEBifmQn0WPuWJBA+nHGLAizMmoKAfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LF2sYhm2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LF2sYhm2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso1969352b3a.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 11 May 2026 09:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778518269; x=1779123069; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iom8ndLx++CwN+appoNm2rlIoGdhrDtcVkMkfINFBqs=;
        b=LF2sYhm2GLgQLeLhXVL8vsh/HxZgBW7CadlInghKiCU59+ExxTIydxmAUQPJDcTKOH
         S1CyMXv9T7+lFRvQBHWvZ6xS2DeUHHSL38mB74OuODa/MsFngoToPZglmYYrSmAlSL31
         V0PPh+LjxSWLNvNn1S6wf3rlPWLHxtM7JMO+gMNOSOJ2SeX40jdvqGxQ3SvNyC35rJbw
         qrr90JoBwCbec7tImhw3gMyIsDU5vb4VGwwcIWMr5VkXSikvh/VHM8c3n6TnCMFP0YiK
         dYTPcbbWKi4ZQo8xCs55qeXxp7Wistk6C0sZXaqM+6yzn5WqzyYzN8icpNsm4VjWUdwG
         XBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518269; x=1779123069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iom8ndLx++CwN+appoNm2rlIoGdhrDtcVkMkfINFBqs=;
        b=oEnjaYJf1zq3q1qmlsiXN32sfVP1/V2ycseIsLou3Qe+ixEKd84yI7FsbfqTKa09Ad
         2VFj9zV31LuAGnbZ4B9IrbojZ5pCZULO7E3unq3S/nJSvrLSbRcuO6L4huCdfrDB/zF3
         kWg0ENl+DOoF/qSgGZFHcnjNp30W6ca5+F4KOMyD63/w5mbQL0WptRpIxHgAi7FmsI/i
         knpzOngq4elkADJtfaBvp/8gNf8/cZzbMjKoL9UP6C1COOwGYJveuVetAV0woxE/HPTx
         hKvwntM5QdlNHF4pVbq3/J9BUzKC4K7lHXQFnVxvB9zIqC/JdN1rpAGmNToPFnhJEfav
         oiAw==
X-Forwarded-Encrypted: i=1; AFNElJ+aAk0wedyK34iJgD/mIRL3JNQZ1TqCpSSEhP/aKbUZTZfxPCn42pgW2hTsgiUG2hJnJXpTYHJ4s8N6Qoc0VQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ2qcVKj4P/TUm0QCwuhFBI7Tz2icLxhq/95XoceKc+bnIZ718
	S5C6PX5PwA5YZK2RfSeseuMDXlZUYaFYB7ecJdSC0h7PWsu9L33gXNGJRzo/nI409gWvtDpYvns
	xu7oBKA==
X-Received: from pfbgh1.prod.google.com ([2002:a05:6a00:6381:b0:82f:2f42:2da4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3013:b0:838:3404:c2b0
 with SMTP id d2e1a72fcca58-83a5b8d9aaemr23075127b3a.13.1778518268359; Mon, 11
 May 2026 09:51:08 -0700 (PDT)
Date: Mon, 11 May 2026 09:51:07 -0700
In-Reply-To: <20260508181717.3230988-5-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260508181717.3230988-1-dwmw2@infradead.org> <20260508181717.3230988-5-dwmw2@infradead.org>
Message-ID: <agII-2_f_gYMdPzL@google.com>
Subject: Re: [PATCH 4/7] KVM: x86/xen: Remove unnecessary irqsave from GPC
 lock usage in xen.c
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Durrant <paul@xen.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Mauricio Faria de Oliveira <mfo@igalia.com>, kernel-dev@igalia.com, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"

On Fri, May 08, 2026, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Now that the hardirq path (xen_timer_callback and set_evtchn_fast) uses
> read_trylock() instead of read_lock_irqsave(), the remaining GPC lock
> users in xen.c are only called from process context (vcpu_run, ioctls).
> There is no need to disable interrupts to prevent concurrent access from
> a hardirq user, since the hardirq path no longer takes the lock.

No longer _waits_ on the lock, correct?  I.e. the hardirq path can still take the
lock, but only ever does so using trylock.
