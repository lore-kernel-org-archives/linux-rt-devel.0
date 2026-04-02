Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0D283FE5
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168597; cv=none; b=nkf/iXZon8cJFWjaMdUkgCOP8pKigM5dtie8yceyRFOiRWgWbKiEUZbDW0IpIW2TVcriX/piRvkQmciZ0BjXRoIzEeQ1qOyK9o20M7HXMYv+NMLZMaakJNX1RFS+wvAq/n3VfslUJjJQrXj4W1yFV/JQnVAbhK1GHxQ+uVKEnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168597; c=relaxed/simple;
	bh=NTwFdoG2LXLVbEjzrgUHpb7V/55TIG6J1/dw1GMmvCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EVSb2N2Lo9FRsk5E2akd0L2RXrcAbaIFpXyTif9MTKYaYYMWP9dNKB2KIcKvjcOsW+jkFEeCbcZWg3zMI3xl9zchgVnujmv9vHTG50dH22yBQjqMDbEM77uNzYdSPoceVG9kAWh7V5NKt7b0Saqr+i8UFn5zM6e+ryTDIESBAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izX1/YZI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izX1/YZI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cdf02bce5so972962b3a.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Apr 2026 15:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775168595; x=1775773395; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c1tFd2YWULWQ0nKOAfJH4m9pKG3Qe9WX5xKtp0LwQ5Y=;
        b=izX1/YZIcmUFYDN0RD9PqsINpz2ZvqjSId5W2vm9fy/41YmFea03kSq3fHqYD3YEng
         hjrC3jg5mpe2ljHbdPdWeDflrsGjVrX3twFpLWFTWPI2oytJPlNz+tbZAiAYeNUgo0aA
         fjtguSp6C66Gct2AMEwMPif+bxKdHQE584SdMnlcRonQxuqLst9w4/LqKQACKt28XxoA
         QdwrzByKBidpYPU4ezHwZk+4jA870GrGLszjhDmRZmB85W91+6dJQqY7nDKX9hixf+yV
         4Df3PrcBTo52TlM9kt7rRjN+4at4vK2e5hc6dpUy+0NfaEGmhVX5Wh3tzaJ27nxrQxAt
         cfFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775168595; x=1775773395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1tFd2YWULWQ0nKOAfJH4m9pKG3Qe9WX5xKtp0LwQ5Y=;
        b=kld+SC5KX7Co1AMAUPoEdFxDGMq4KrPD0kWA/h5+oAWeUK5IfeGEPghQ4/xlloAtqX
         5yZAjv8BzXylNbuw2sNJaP3hqnP+PZSS8o1CIhT+5NhnfI8GHZ+0bBe1yv3AptYcvY6i
         d4Gc2Pe/u7S7n+QDIS4wPOS8JiWuVgp6p9JqGsa45TClxTpQ+fu23zCs3VuXqHRe3PPg
         vXbO/c+JZnghzdnZNmcV8uoAWx83sTmoCyaP0jwdcn5cQaui2k9nX8BV5W6fVg0Z5uGx
         PwGBG824awLNrMK0vDLLH/QiFq5i3RWZzNCBFKAl8wzCXwr8NngJf4c5zad49xT/qVEQ
         +uMA==
X-Forwarded-Encrypted: i=1; AJvYcCWVvVwS8LG949QdoTlOckvPjwGQ5kF20zkquEzH050PB0jCwLiO6K7Xfrjr1pa7am9LK+iZwPllpzxy4CcpXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YygLRyBk8dqAWeDsxCuVdVNiNXnhFh1mH2/lq6ovIU7G+315IT9
	FDv3pz5R4y2qFQNHXnoCV3iwv7MoUpj9oaDGqhKKbOSiU9tbC4HLMLnobQ+SJgyCoqNCLcV266b
	xgF50Kg==
X-Received: from pfbea27.prod.google.com ([2002:a05:6a00:4c1b:b0:82c:ec3c:f2d0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:f88:b0:829:803e:6798
 with SMTP id d2e1a72fcca58-82d0dbea543mr625141b3a.56.1775168595062; Thu, 02
 Apr 2026 15:23:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:23:13 -0700
In-Reply-To: <20260402064209.8ba7wrBI@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260329131543.91733-1-shaikhkamal2012@gmail.com>
 <20260330101814.7fa1e31e@gandalf.local.home> <bb7b66ad99097c5326196b61d644cff255e30394.camel@amazon.co.uk>
 <ac08V4TaM2yh9SY1@google.com> <20260402064209.8ba7wrBI@linutronix.de>
Message-ID: <ac7sUQZ0AQIMFDnL@google.com>
Subject: Re: [PATCH] KVM: x86/xen: Fix sleeping lock in hard IRQ context on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"shaikhkamal2012@gmail.com" <shaikhkamal2012@gmail.com>, 
	"syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com" <syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com>, 
	"me@brighamcampbell.com" <me@brighamcampbell.com>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Sebastian Andrzej Siewior wrote:
> On 2026-04-01 08:40:07 [-0700], Sean Christopherson wrote:
> > Re-reading through the thread where you proposed using trylock, and through
> > commit bbe17c625d68 ("KVM: x86/xen: Fix potential deadlock in kvm_xen_update_runstate_guest()"),
> > I think I agree with using trylock for "fast" paths.
> 
> Has bbe17c625d68 been applied for PREEMPT_RT reasons?

Ya, I think it was to suppress a PREEMPT_RT-only splat:

https://lore.kernel.org/all/20240227115648.3104-8-dwmw2@infradead.org
