Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583271;
	b=E9x6pGnnAGAXnJtjk4nA5MukeKC/+rz9h6gP9jIOr7KxQLhaKMI+sAyVZe7U6PIlHt8m
	 F7+C9ys7PcivcKqAtM/JpSu2PkLLuDd0rLIgpFt/zLT3ddB4j6h7meZEZHQf+E7V8RD9h
	 XD2rWLfIvtAMsvO65OgTXhHSpG+Wo9sXOZwVT8GKGsv96V5pPwPTWben0em/uJYczDDKm
	 Yr9fHclBozMSuGU1HdyJRMEbeafgd6h9kzTqjE7t41BtsO99wvosNn6WrQlM51FlXuX4f
	 NcBunRLTekF29Ri2QF1xkLlJUYZyQboM1XFUp1qozc9NCVqdlBQR8gBXYLvmE3Q8wPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583271;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OjIDt+f/7+dWlNv53r9qvEutgjmi1ked15ytPMp8nBU=;
	b=rYv1SooK+JWRyRH3JohG67B4DGRzrdJ/oCtbd4teM6p2DQR+5RW2ojKEjnPg9u3L6QCO
	 l+PIZuZxVZ36uUP+JtdFjzRfAIqMJ6IADv3kHv5Db0Dt9EzZhq+fBaCeZki6lG9vLl+4G
	 4mpJdGBVhYERbox86UFuH+54Sa0ZCLeFJU/dbSxiuf1saYRqDWZXZM5X2Xv0Ga1yl4RmF
	 RJAc6akiY7LuChnNaEy9+z49gwyuF3uXQCZmuEOMl0KzAJOK3vN9eGN9dpr/r4+BHk4Eu
	 d7qfnBNug2lFJ/kyNH1Ykqf//d29WY40BG8VMfC/AveaZXRCuSd3xOKsCmvxLeeAVVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E773606A32E
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E773606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67bee1f693bso888631d50.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583270; x=1795188070;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjIDt+f/7+dWlNv53r9qvEutgjmi1ked15ytPMp8nBU=;
        b=hlx2vKXwVd0c8BAE4FHvKRT6RHyyQnXELPKGyqaS6ACMk7pyMaUFl83f//iVM10jMg
         ExCGH0FM0GVh7CPNW5Biiv/eN0mbMGPTScofnhWDUFQgQ9iCKzQ8BYIU+Bjh2GeWGksx
         FSziyiqozPHAwptQHe2gHQFK7oj8Nqzmml9d9p72O8RVsCfQhEpojXiU4Zi97mA+KvG8
         My9vcLE0z1c3MKLncSUC+dzryjuVfcu9ipkpKfOR7CleVBVkZUblHbU9rXyBYvfcsO6X
         Bo7kJCMediEd48kOyU8sK4SohF2q6l8h90rI8X6z6Eq1RcFRPt87OZS/96qCpaWgImXs
         DfYw==
X-Forwarded-Encrypted: i=1; AL+hErHuXtloIlotvHvHcxmpmeiQysx0c9GPlykaEi8D+548XNoT2HtIWiX2L96g9F9mF+qgy1E0dlIxtC15nddTZg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8QPdxNSChXF9XcDJzsMVLjky2a00kD32otiB1ONz2SERoz88ek
	DM+Y8Yoys7O+rg3ihFwLreQmQem+4BGYBkIsw7uqK1brKIuQ88Zxgm13
X-Gm-Gg: AYBFou0+GK5EIM01dJdPNmbKGfwgtcb514u26BKYsmQ0FNrTR3S8ACkllCkZKJ/+w89
	K51SOeEQHgk0OTv/6VOIaz71YXzfKfbHIDf8yxVVAfRZlFlVgIS83pRavoTwhpac1wbW52UBFZW
	fmhKUD3ZwO05Ewf8NerZGe0OweugP/yusO1SnPUKEaNm+U/uzjq0Pm9gix7k2BCmS0ER3tKDM4N
	WatZlQSOcxYXUDkiZ6OqpoSZ3d+YUuI/YNFt9VIgF10O6d8G6WgT/zNo6ZBEtlv67k52tna3wwB
	jn7WecAz5YU/W3v9YVEPX+yQ4c1j/Xts3SjzTPhSrkKts2ggAzUzMITyTxqJPAhYkn9jlQv9I4o
	1/jxmSrpf7NWfDdDsvBz7Vl/USWcBDTrEXFUoH41Pn9QhuAGPvknGSEjig6RE7dGVRTqWCWpPPe
	3CEZvGov96gplKjxXc0m5F1vg5QuLnViOh4OXqp2Zvvctyocvv8NC0KCOA18bWKHQzZEPX4EsEu
	WpSNioZWGOwclJTnMVv09iCQWymoSpGnAed0REwot53onDltSQ9yymqjbpNO9jJB/zlITa5q5qq
	gSCO3ERtvktcfEOSbxSz
X-Received: by 2002:a05:690e:4503:10b0:67c:2b34:319c with SMTP id 956f58d0204a3-67d897f540dmr1252728d50.78.1794583270342;
        Fri, 13 Nov 2026 07:21:10 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:4e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm2307745d50.21.2026.11.13.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:21:07 -0800 (PST)
Date: Fri, 13 Nov 2026 07:21:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v2 1/2] netpoll: use a raw lock for the deferred
 transmit queue
Message-ID: <avcqBLwy_TB0w6PF@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260930192103.62973-2-kmehltretter@gmail.com>
 <20261001074819.gQ3w8q6P@linutronix.de>
 <ar7sTVun7mF-4nl6@gmail.com>
 <20261009155225.6Uy7b0wd@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009155225.6Uy7b0wd@linutronix.de>

Hello Sebastian,

On Fri, Oct 09, 2026 at 05:52:25PM +0200, Sebastian Andrzej Siewior wrote:
> I would suggest to untangle that local-irq-disable assumption. Then we
> end up with the ::write_atomic callback on PREEMPT_RT which will raise
> warnings. But those will appear only on panic() and as the last console
> due to CON_NBCON_ATOMIC_UNSAFE so everything will go according to the
> plan.
> On !RT the whole __netpoll_send_skb() will be with disabled interrupts
> due to the console lock. On RT it won't and I don't know if anything
> down the call chain assumes that.

Thanks for the patch, On PREEMPT_RT, the send path is clean.
all the selftest I have are passing fine, without a single splat, while
the unpatched kernel produces about a dozen over the same tests. 

On !RT, the first message triggers, but it doesn't seem a big deal.

  WARNING: kernel/softirq.c:453 at __local_bh_enable_ip+0x118/0x120, CPU#4: pr/netcons_netc/307
  ...
  Call trace:
   __local_bh_enable_ip+0x118/0x120 (P)
   netpoll_send_skb+0x1a8/0x364
   send_udp+0x348/0x4a8
   netconsole_write+0x16c/0x628
   nbcon_emit_next_record+0x150/0x3cc
   nbcon_emit_one+0x74/0x158
   nbcon_kthread_func+0x18c/0x258
   kthread+0x108/0x134

Anyway, is this patch something you are planning to send officially?

Thanks,
--breno
