Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C34314AE
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469192; cv=none; b=Sw5Mq0TQTfQTcztnHh0DexCaQ9tdyIlQhr5Uh3IatHluNKA2Qf0HZ9mvEFaV4uUiz/tFf5DscRZPM+VFHJqkt/5prg7PmEe4rhy8up301OBb/G/Ym+AgN0yZE1aC5I5R2Zk/iKAl2QM6LtkWLRCTPFW5dzQ/7tQhI7Y9xSEJfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469192; c=relaxed/simple;
	bh=PGN/23AcG1BdZ95Dbjp/XFqXT+g7ycHtDWwLc+SPRNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6RP5Apz2GtAr0ryffxDufZTqym6X0Ar2nUusIzH0CTKlGmXzq71sYtLkelwMeiO+gJJMdyN+2oHgY1pkq0gXAvTRxiU7I6J/QrGFzIny1+sMUiBUDssYNKBNGMoJx2py+I2hjE/Kmj8VVW4I0pBYegUi1DH8Il82Nya4OHx2Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=hsg54MdM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hsg54MdM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-908934450cdso512516d6.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786469189; x=1787073989; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T9Qh79QFCvjYnoGtVduyp1NZZfqwn8kEM0DsabkDFtg=;
        b=hsg54MdMQPCU14cyQSlxlrze3TXtqYQutapZo+x+bRC3pUouLYBMQuoD5FoQ109icA
         ufnDkCLqEfZi9+/ZpljKY7fqORntfK4yNMspqCKd4ctoqWSrtL2wprdPW4ETOqHCzYcc
         vR2SZjg5atae7jJK1bMOUBKlrNyUG+IgZrLgLdXK1yemvdZBcwF3stEcq+/ui0YUYrKR
         lUyvQppoTHFMmxXWGMQZeItY+k1L2+YUdmF26YS7WaYrjw7pasSkurPDFYv3y9idHmZZ
         Jz51vI/d3QKaOALNuZuvmCjCvxlMWi6UIlDsWJTs1P5klO+j0EqSMqufNwtxHwqb5qrh
         zVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469189; x=1787073989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9Qh79QFCvjYnoGtVduyp1NZZfqwn8kEM0DsabkDFtg=;
        b=m9RHIZ9UpwznnbDbmb3HrHqWNJVAoxyahEHSFqjha4TFljnewphf9TUieSSxKo59Re
         rez/J4KNwXeUFHV9pVt/KIHptPwOMkIkEyOcnR4csabss58U9BTzCfLlztTg2MsgW7LF
         DlnF0o9npe3+/BNKgjm//QtWZbJfwtKK5pBP1Y+KXTqXMSRMOUnsEMostKR0OXoAWdUx
         LdIrfM0AW6JcFbhMCo15U3yl0+WbxkgIQiA/wydY8OrGtVUgOnEAhNT/7Pnoh4ukFpxZ
         yDjF6DJqwOIuvcIlG7Ywf9vvHhfkDV+T5qRpDYuvP3MIh8nlgxnSzHrwyT1eQyBadb0R
         1bow==
X-Forwarded-Encrypted: i=1; AHgh+Rrhzz2a+gwNQxmQo8Lc3g0S0LU0Im6qAceMJ6SRGWaRBPuXX4osuciaDyalLaauvEu9+4fnGjyaS0aGnwQTpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmFOx0oPkBCPT9mRXFAhWjUEdm35X5QJzGB5JB2xS4DLxMdc8B
	13wCQkS6/liqoZ456NvtsV1g2tOSptPQDptOKYJkwtV9XL/cUXuCcBwLhCfvbvmPZ6Q=
X-Gm-Gg: AR+sD13lV+903p4VnZmPeNcRHpOgxY1j4padhb5AAhLJXqLLL0PVtyIvTLxL5CCSag2
	qX4C52rMtJLNYm5MkcFxtvaM7TqyT4IfYsdm9Un2Zvshtb9joISCtEFnuqVxTPWZ7SdMs+6n0MZ
	U2L/RoxdTUeSTy7pBMaHnJPoIMX3yQmqYLOfTlLkS4twWOCBhofKNKuJ4qnfe0S+qB2nOSRGlZx
	dTlio44ml+OmxOnh3mqhGWbjFqz/+g2GtawhDsclMyUhy0RBSe4IIZTe95N77j6djYuf6IHAnYk
	6erU0v7AP5rHOAtZsWKOZjYQYB7IqB0KY6Pucbu10vUSqEmYrkK/bl1i6SSJU9PB/hxuV4IONky
	NF4G3c8RjQhU0ktSa7d1AcjwhLPgF3gq1qtEqYI3fuYOUKc/uxxyIuhPEN2/Wa7EuJ9TAtEop8Y
	/J6vORLIuZOQF8pZl5xJfpj/VqJfBziv1bKGq0bQ==
X-Received: by 2002:ad4:576a:0:b0:907:d9bd:2f8f with SMTP id 6a1803df08f44-90a6694b0d3mr50111416d6.6.1786469189079;
        Tue, 11 Aug 2026 10:26:29 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c3c8af4sm3611196d6.39.2026.08.11.10.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 10:26:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtqF9-00000002gAk-2Giq;
	Tue, 11 Aug 2026 14:26:27 -0300
Date: Tue, 11 Aug 2026 14:26:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, mhocko@suse.com,
	rostedt@goodmis.org, bigeasy@linutronix.de, simona.vetter@ffwll.ch,
	jglisse@redhat.com, christian.koenig@amd.com, paulmck@kernel.org,
	seanjc@google.com, pbonzini@redhat.com, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260811172627.GN544626@ziepe.ca>
References: <20260811162423.GL544626@ziepe.ca>
 <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>

On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
> > To be clear you should not be using any synchronize_[s]rcu() primitive
> > inside the invalidation callbacks. These are well known to have
> > multi-second delays on loaded systems which are a completely
> > inappropriate performance characteristic for these mm callbacks.
> > 
> > This statement has nothing to do with deadlock.
> > 
> > RCU is always a trade off, you can make the read side run really fast
> > and the write side is ghastly slow. If you can't handle the slow write
> > you shouldn't use RCU techniques.
> 
> The multi-second horror stories are about the *global* RCU/SRCU
> domains, where the grace period has to wait out arbitrary readers all
> over the kernel.
> 
> This is not that. It is a dedicated srcu_struct, private to one VM,
> and its entire reader population is a handful of KVM fast paths that
> until now were under irqsave rwlocks.

Are you sure? I've never heard that srcu has those kinds of properties.

If its so fast you should just propose a non-sleeping version and
leave the notifiers out of it

Jason
