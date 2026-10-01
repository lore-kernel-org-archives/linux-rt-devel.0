Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B93B2D0B
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 Oct 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897452; cv=none; b=X9hLA97YjLaDx8e6Okgrh0F+KhL/pC8NLOWXLKAIwn0CZyx2v2987jzahf+oWjf3pFqyXeRKCQ1Y26Gg4oxpqYlc9qcu6fAWyrRzNMVPULEMSjcwSvp+bG7kUJS6bGWWkpCVh2v7BYAgcH9ZVkk8UxzyihZ8Iil6efbXNM8fr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897452; c=relaxed/simple;
	bh=WQqvvD/sQatAVKeDt7OzSCnSoyrrtfFbAK2i7nM2NgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK4CsRjHbrYJ62XXSoAlV0Xm9sqZUPyID6dZsxHF9SmA0YkAZApwzqwLGwk9/uUsUcuyJUW8JRF1mb6oMwctokuOXz9iQkjbSmqv1ZJuHC7pss1JjD5X7xks92mwSnk3DP5xpUxagtkXF4MdUCa7Udf8xp9AgH7KHVKE9C2Hqzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A50lDTHa; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A50lDTHa"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49fff6f0f87so39760915e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 01 Oct 2026 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790897449; x=1791502249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMTt9X+tMN/0URvJisKt8BWrlZlLlxVbSwTrZVovw7s=;
        b=A50lDTHaXCyM5aVmN9rQbPykS3XuM+oXIM4S0WPcN+uZuZSpcdAfxHiF6LZzlAT4pd
         Xko+bFT/nXUbQbsgpUQxGEZEHuzlRRKuoM7GLD+4s5I++F8YzMxlUZdNs4o8+lcXCmiF
         OFrYulN53ERsN4/mpS255fGMaqytq8Vw8YYivsMMTpSUFbCyXdpBRRr2p5mq6a2LIbTz
         RCtKKaDIY3T2NtXS+MXZCtIlMEdlnJxqPl699CRoQVShaohN4oyivjf8rTY5X1ApOY8f
         4j1RM66MAkY7EB73gsHZa3nU8IK26DaY4BATULB4o5/JdzkEsFxcsozP5XWBCPMmQOLM
         nNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897449; x=1791502249;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMTt9X+tMN/0URvJisKt8BWrlZlLlxVbSwTrZVovw7s=;
        b=PYjz1c86FwbRkb/f17+xYhl1po68KuA9C1BfdshB1k1fyR6K5vZi2z/v4a1YHJg11e
         MpNk6XlSR8uX+u/H4Fw4iVeMh6YTe8MluKtMAQUZn5mEl/WKpn4Ho/ItyZRVcupUw6QD
         8SNSZrA94e54iROAu4GD9MYvyYm/OVp0wAlWlFOTZ+0micPWlyBR9I7skJm4zvFGyptQ
         GTAHir5zgHT5XLKnGujy9m/5BZR1HCaAnLw7t1pJgYaWvomoO4sYNk7ly92AVheaZKYr
         /tsYHlv4zAJw5g0wM/aAEimBPXjCAmwxyZoaa3vDmXvfzd5xA6kHM1CemWqqWNTwaWUH
         DXrw==
X-Forwarded-Encrypted: i=1; AKwUvByXjD1I8UAWXZx3EKTBjCwkEK6yQR40T1vT7KzPI61x0ahdLUlrWPrkwu+3WAz7dq0O9sIt/sopbnKjWLg3Ug==@lists.linux.dev
X-Gm-Message-State: AFuF++k4jj2lufwpfdPWVtj4qtqiVfozEHl7P9KXT/UN4Mbyyi5GHCrA
	8P+0yw3R/DmvNvWxJNHrI0fK+Z2HU0EloSjY9rklSvKjzB7/y3crFOPO
X-Gm-Gg: AYBFou1CO0CTRPRDEZmR8g441EOhOp7gph0pcQJEj0Ev7tUCu4RriooMNRaM4LtMaar
	JH7bN5o+t4Z3mQWCM5G1mX1fSSiSsNxaQUppsEogPbyholCkcnojGdSnU7ip8s6ebZFp7G/kSMs
	H1ljwvU5HtIYw178vxaxILZ7iIBHwchTh11cCsDhzb3WsJ6IeT11dEON79DhI+/5FzC5d1D65KM
	8h7WQepxxkADNDpXOJ301NsGxKG+gsFIQffe70Gw/6SUvQKRGD/CZ/OZYg/izJzMp9U6Kcc3Rkb
	kKYMIlnexsHTmld4+HjUS4JutdOs/dkDZ1/flPrOAbiPhIjtXZK2TKkqb2XD7fOt/GSNwYldNU+
	Wb3NIxYgR8+hxQd/uNN2hCw2dN9jl8+NavfaENEzuQyIGZPOcMaa6ow3ZRKC3Co7t9RMufNvVX1
	aYRELFMx3HMD2w666dxmZUnSY1aoTARlc7VIr4nuXEU1YW0Fr5iXOZ0hohY3G5jCGdCTN4ToeZX
	7nNDjFBHEzq2jbC+6oZs8LPZELiBMQLDEzLvV6pLJ3XxL7+Cy2WlQEgwLkSoB9+L8s6J0N4w5nw
	OFqgZ7ecJdwczNF6L76cK4S8r2KPK9cljeWqF/xbTb1sqzSN3HUcvh1vo3CKHuAA2hmqfGiYvFn
	lNfwKUtRNnA4=
X-Received: by 2002:a05:600c:3501:b0:49d:2562:d670 with SMTP id 5b1f17b1804b1-4a02757ab71mr17738425e9.14.1790897448522;
        Thu, 01 Oct 2026 16:30:48 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-b3ca-3a01-3deb-81e4-0dc4-fbe8.310.pool.telefonica.de. [2a02:3100:b3ca:3a01:3deb:81e4:dc4:fbe8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03feed16bsm11717875e9.4.2026.10.01.16.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 16:30:47 -0700 (PDT)
Date: Fri, 2 Oct 2026 01:30:45 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <ar7sTVun7mF-4nl6@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001074819.gQ3w8q6P@linutronix.de>

On Thu, Oct 01, 2026 at 09:48:19AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-09-30 21:21:02 [+0200], Karl Mehltretter wrote:
> > netpoll_send_skb() calls __netpoll_send_skb() with hard interrupts
> > disabled. When direct transmission cannot complete, the latter queues
> > the skb with skb_queue_tail(). The sk_buff_head lock may sleep on
> > PREEMPT_RT:
> > 
> >   BUG: sleeping function called from invalid context
> >   in_atomic(): 0, irqs_disabled(): 1, non_block: 0
> >   rt_spin_lock
> >   skb_queue_tail
> >   netpoll_send_skb
> 
> How is this possible? netpoll is only used by netconsole right? And this
> is CON_NBCON so it only prints threaded. What is the missing piece?
> 

The call is from the NBCON printer thread, but netpoll_send_skb()
explicitly disables hard interrupts around __netpoll_send_skb():

        local_irq_save(flags);
        ret = __netpoll_send_skb(np, skb);
        local_irq_restore(flags);

When direct transmission cannot complete, __netpoll_send_skb() calls
skb_queue_tail() before interrupts are restored. Its spinlock can sleep
on PREEMPT_RT despite the caller being a thread.

The deferred skb is later handled by queue_process(), a workqueue
callback. Its requeue path has the same IRQ-disabled locking:

        local_irq_save(flags);
        [...]
        HARD_TX_LOCK(dev, txq, smp_processor_id());
        if (netif_xmit_frozen_or_stopped(txq) ||
            !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
                skb_queue_head(&npinfo->txq, skb);
                HARD_TX_UNLOCK(dev, txq);
                local_irq_restore(flags);
                [...]
        }

Thanks,
Karl
