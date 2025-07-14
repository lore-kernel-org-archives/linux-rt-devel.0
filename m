Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511425DAFF
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509458; cv=none; b=E6CPOwatIi7NDO0Oes5iw7ufeuUC5Gs13UE/bkVqUBB1ZbwxBp5qs4D2naTcfeJtvRymI1AYElnduqiuiQUoLwe7lVF+bPjGON1ib2ZvKlDoMMA2+vA1B+G++6G+0CriAc0n2O1+0aj0M2KbukjNrnPyWwhYO5euQvmZQV5kZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509458; c=relaxed/simple;
	bh=TXBhF2hsvFF6n7aCSxrTP5ln0Far7SI/YRoW6S4tmUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qN2vdVsA6lh1cpSaoL7W5wEit2Hn935Sh8CWRzCHoNxGbdFIIiLaRC0/LcvGo6rJKJZnKhAbhUMAJReXRAnkYEB+fkFqDSmqyDf4C790wjV8EpeDkXzN/BcXfwwr7hyf64pJdoKm+3zD15L47s1jtATmfzrlLwl4eqOI4lI2Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKoox0cX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKoox0cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752509455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJded38NkCminVRmf+Vkk9veSOaA59XspWkWKEaxDxE=;
	b=BKoox0cXnA4zT6zAgBsdaAyPkmDrDmoM+bE0jT81BHvhneMnKPhv5ZqpAoIRqKPCbGmjus
	fK9564sCmaP60B9yQkp+fLZ4+fM6qNWNfyN+p4hJIBDrGdlRGq4hYIiAYBv/00Iie67MsB
	5OV559h8lmkoo59UtNsaLAzNi9VpWtQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-oS5XBjohMAa3UZzYkfiE9A-1; Mon, 14 Jul 2025 12:10:54 -0400
X-MC-Unique: oS5XBjohMAa3UZzYkfiE9A-1
X-Mimecast-MFC-AGG-ID: oS5XBjohMAa3UZzYkfiE9A_1752509452
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so16942325e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 14 Jul 2025 09:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509452; x=1753114252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJded38NkCminVRmf+Vkk9veSOaA59XspWkWKEaxDxE=;
        b=JPEP6x5xeWX4LJH1uYQrvq0EJJ8O7LmfOQpqmHoksmRj7Kzaq1qKM1Na3kG9ilQI07
         xWv98+MTEmdGgVkHPOhlvE8gRlGTfcT/J/ch/zluwzACQoc6rJ+777aM3ut+UWgC5O4s
         StjCroHNoM43olM7UTZYpya0gXDULOpGHcOYjXb46oitYuuTXDZcgRi0raW6wq6c+PFZ
         SN6nmaf89RTeiE/gNslM4rQcFshA/vnlZHWrcvCIUTu/G8E6Hm/kIAPLMClFgj9bm0Eb
         nnDqicMVDGhzADTWdVzlRJfgq6ePa5cFxzm5GhOLzKoLNzAEmSSUQ0X7jSOiVX6NC21e
         vw5w==
X-Forwarded-Encrypted: i=1; AJvYcCX1vLBzTXFz8Jy55AQNDFB5dqso7LLHGDOkAvxW7QpeoAv8z8MCt1mVNVCZFbFOyeH18Zr9n4rOljwjgvbr4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/uC0bN9p+nt2ur2K34GD0QzNuNxOJmTNf4ms8f934G0VjAZyt
	4cMyOG+Drn9XL0mU+F0qqsrwzMD6btpZz60Bf3PDFq+iR6qeWT2SpzxDDT8twIgqnRGIEdXMSJ0
	eoWPqsAu/XoZ7HClp1MVbFOA2uBzVxzJM+rrMNwhZjdjqHFO7KfBxJBq/lRAm2aePEgYq
X-Gm-Gg: ASbGnctSf1xPdDvHA+LIspP8aJMqDsL8pjXQtL6N+flKdDPZwjV71eXbKJAqI8ozccH
	poiVXCmRINaF0A9Bhwyik65nJX/KpIjQGGcwEi8bn1ESbIz6TR1PRl5FTeBTE3YtAcOtyGXaA2P
	A2FaY+QlqhK7+iQSxqrfvQcw0e4zAc4wpLizG6EO0YRQ7iSlwsA+cyLm+Jlvg4kCA9qlkMC54qZ
	P1oSPbylnTcoT6chVkuZPUnh8k8ZdhMwoAWVrnfbZWn4UYoQpBhX2ygZWn5+bgaix64PX6+IkRT
	h1EcKpYb7B6/OZvf+4/7pZd9Pgs=
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4560c484fbbmr93343595e9.10.1752509451780;
        Mon, 14 Jul 2025 09:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu0KDsL3bCGkwFYj1hHtAGF4TYYoQuLK07nUMMS0J4mW+mZWbbAYRS4px+NSDCrvU4TmUMTA==
X-Received: by 2002:a05:600c:1e04:b0:456:c48:491f with SMTP id 5b1f17b1804b1-4560c484fbbmr93343185e9.10.1752509451327;
        Mon, 14 Jul 2025 09:10:51 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45623f4f838sm5268045e9.1.2025.07.14.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 09:10:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 18:10:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next v2 1/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
Message-ID: <aHUsB04j+uFrUkpd@debian>
References: <20250710162403.402739-1-bigeasy@linutronix.de>
 <20250710162403.402739-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250710162403.402739-2-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g_NcRXZdNxXdkpfM8tXxc5KdiK_m9ff1t91fDeZainA_1752509452
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2025 at 06:24:03PM +0200, Sebastian Andrzej Siewior wrote:
> The per-CPU variable ppp::xmit_recursion is protecting against recursion
> due to wrong configuration of the ppp channels. The per-CPU variable

I'd rather say that it's the ppp unit that is badly configured: it's
the ppp unit that can creates the loop (as it creates a networking
interface).

> relies on disabled BH for its locking. Without per-CPU locking in
> local_bh_disable() on PREEMPT_RT this data structure requires explicit
> locking.
> 
> The ppp::xmit_recursion is used as a per-CPU boolean. The counter is
> checked early in the send routing and the transmit path is only entered
> if the counter is zero. Then the counter is incremented to avoid
> recursion. It used to detect recursion on channel::downl and
> ppp::wlock.
> 
> Create a struct ppp_xmit_recursion and move the counter into it.
> Add local_lock_t to the struct and use local_lock_nested_bh() for
> locking. Due to possible nesting, the lock cannot be acquired
> unconditionally but it requires an owner field to identify recursion
> before attempting to acquire the lock.
> 
> The counter is incremented and checked only after the lock is acquired.
> Since it functions as a boolean rather than a count, and its role is now
> superseded by the owner field, it can be safely removed.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/ppp/ppp_generic.c | 38 ++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> index def84e87e05b2..0edc916e0a411 100644
> --- a/drivers/net/ppp/ppp_generic.c
> +++ b/drivers/net/ppp/ppp_generic.c
> @@ -119,6 +119,11 @@ struct ppp_link_stats {
>  	u64 tx_bytes;
>  };
>  
> +struct ppp_xmit_recursion {
> +	struct task_struct *owner;
> +	local_lock_t bh_lock;
> +};
> +

This hunk conflicts with latest changes in net-next.

Apart from the two minor comments above, the patch looks good to me.
Thanks!

