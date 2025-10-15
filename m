Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C030FC0E
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Oct 2025 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568380; cv=none; b=PRWEccfFK3ffmhyVQwJMOZ8C6+xWnBLRYhTlloVU1EIHx2PSoJwHUdqo44rKG/KUdX73nLoYleY/EKyi/S/0bkjnPkA4CjGjPFNlk2pICiClQm1fg4mza8RteXk5iUvwAG3qGHBM8oKul0f+ONE2wgreAUfFIz3uL3EdBy/GuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568380; c=relaxed/simple;
	bh=gn+jrn4+7QL3Axwt5qY/3ILmL/rIrIqQI1AE38f9NE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbqXrSAh90j0pqgyHWaWmjE1CvH3NUfzp1Ik2jEgdBLaig6VrNVXSsY7Utn+STvBx6yIdExYG2DYi7oomw225qLn+56T3SswufX5Gt/aylNsFXGzLK0r18dg8vWONks6IxFyZMe9+JqORqMvYxM/uSG8cLGEEElI6Dh96/acXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXikA+hJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXikA+hJ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso570715e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Oct 2025 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760568377; x=1761173177; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFKGoddm59QoTZnWfmZZLtnAiNTcYZnAo8RKS4lX25U=;
        b=EXikA+hJNX9yWqjnhSYGERWrgJ0i14ScVJ2ymZOo0G8zLkwNECiqbWw6S5LKiSuHU5
         QFxjwXXnK1xIlBR87kl/cgH3kAKjL5QsdL1WEDTTDaxEHNjZND0z09TS2YH+s+YX6iXA
         O+AMP9oNZwK2RB8RX5mxRMp0LgX6xx1MXiMCgiP1UjT1bwe6LaavT4pzwVxlSIV+PbsB
         EGA4t2SoSqRzL9BxmaBaE6o2PVd/kiyZF3TWL7zVO4JcaE/hs/mWB2T5MeE/YmlTRSVh
         PFQoDaeffkt2Ps26hZE+yHAv4mnQSfZDQKxcgfjB6pOxJd+NVT4r8K6iGWSp/67kX3lw
         YHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568377; x=1761173177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFKGoddm59QoTZnWfmZZLtnAiNTcYZnAo8RKS4lX25U=;
        b=B1z68Bfu5lWq+QPTkkekTMcHj91lDpJDw63JAWYHqpRp1W/ip/0qq3Xr70I9MKX7R9
         ZMdg1q4UPDjrcnhhuGD6KKXZ1YupBx55nQgnGAXBqCuO67fB1HVSxfsGb/FZGay9timM
         +RCys1UhBftdRlvtQ+lgqkILn6rIXVJjjs3/xZFHqCr0pP4pxOg4ww/Gq2WK9zTqgTnu
         /1TVuTa2wly+qoM8urfTpA7Mv7bwZKPbfwCyijA3uhfNEKczj+/Cc6RBXtqBIhAkHBUT
         bTXN1fQDqQXsC3SoqVf2N+nbsn0RdSSh65wazJLgXyLYlAqlAuiek6N8WptfHvWgUucb
         noHw==
X-Forwarded-Encrypted: i=1; AJvYcCUTAhe5lx9fD8F8ADrPXBNLr+JCJ5rThgy/IxM1ex2Ufdox/K1dDPnH8xsVcsL0PFLhrqzEgJjLcG4Frve25g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj8RLevRXJqok9x6OFBwka8nMNGAe32hGcq/VtNA7ae4wHJ9la
	dHwHsLngzTVx1IXkTYbjmkjW8KXiwS45VHszHQL8AANsRVhp8tq2E3Ap
X-Gm-Gg: ASbGncvzUsEOJGULWVUriK7BZyw8HBdJ3ROmqH0xIShaN+P1ht89g/7ulZWA5rkiNdy
	8m5aFCMzfPdYjasZ8lbMbrrYvpjGzeqwPRfNAAdRbbjhWkIlMzkZEBDxbfWwVS4KRa6DtGh6OaQ
	+TI1/wyn9rH71rfYptWVTQmIIap/CjTfSjr900R3NF9rCCfz8DyrT6W+XoaBCUm+PU9ZwAue0PR
	0XPHX9L2EEQenFBnwMG90a0+erv8JTO/NJ0orMpnPkHxZr3HIUrq4ZLRHX7Yg4E+gJtdTzixsns
	G7u7XIA1rOxnvJgWnVXXO9LDoAXFIJszV8vqxnP2IFM4V9//WqkLJbT3eeWfJqZMBsVbrKGRosT
	ASwtDS8yfqLFWyOF4DQEoqZG5GH7DFAJxM4GL58OXu9IZ15b1P5t9j7xtDYhdNC/u4ls0JA==
X-Google-Smtp-Source: AGHT+IGDAo0cT2+uD/d095c1GDJkVJ/8fi2Txwb/AFql1WXRzzbLwuRU1peuUU2qA3ABNJ3YnTjhYQ==
X-Received: by 2002:a05:6000:310a:b0:414:a552:86b1 with SMTP id ffacd0b85a97d-4266e8e48ccmr20078648f8f.63.1760568376783;
        Wed, 15 Oct 2025 15:46:16 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f3fa3bdasm9095798f8f.46.2025.10.15.15.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:46:16 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:46:13 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] mempool: clarify behavior of mempool_alloc_preallocated()
Message-ID: <aPAkNZDr_HAA_d75@fedora>
References: <20251014-mempool-doc-v1-1-bc9ebf169700@linutronix.de>
 <aO_taH9CKxmJPnhV@fedora>
 <20251015192717.HvwzCChE@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015192717.HvwzCChE@linutronix.de>

On Wed, Oct 15, 2025 at 09:27:17PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-10-15 11:52:24 [-0700], Vishal Moola (Oracle) wrote:
> > > --- a/mm/mempool.c
> > > +++ b/mm/mempool.c
> > > @@ -461,8 +461,8 @@ EXPORT_SYMBOL(mempool_alloc_noprof);
> > >   *             mempool_create().
> > >   *
> > >   * This function is similar to mempool_alloc, but it only attempts allocating
> > > - * an element from the preallocated elements. It does not sleep and immediately
> > > - * returns if no preallocated elements are available.
> > > + * an element from the preallocated elements. It only takes a single spinlock_t
> > 
> > Might it make more sense to say "It may sleep" instead of "takes a
> > single spinlock_t"?
> 
> May sleep usually refers to something that can not be used in an
> interrupt handler.

Gotcha. 

> > I feel like the fact that we take a spinlock isn't the important part
> > here (especially because we always drop it before returning).
> It actually is. A spinlock_t can not be acquired in hardirq context or
> when interrupts are explicitly disabled via local_irq_disable().
> Therefore you should use the function in a local_irq_disable() section.

As someone not too familiar with how the locking intertwines with the
scheduler contexts, seeing something like that makes much more sense
to me than seeing "it only takes a single spinlock_t."
