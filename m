Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C43A313523
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099944; cv=none; b=b57IepIW47K5xLLkOvPbItasKAY0j9Gr9kHUZMwMj9/ukn9TBCqOZMRaqluSXdDq030PL/GsoPmigHQu/wCA8E0Ptls5FMUhTa3WSYFQYebwLRpaMleYHxeeQOzKmVm3FvbUVej7x6X2ThjXC0ZpnSKD+RgOyaFQJLDCJAEv1z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099944; c=relaxed/simple;
	bh=xnsgGhCAvA/FGKQrDFk3LFrWwe8fzOofaCQtVEYGFDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRiRYhm7JspiSVb6hH9TBGuwVHoYPX75VDptnfElMeQrckls/29vtI/JxVTVGDVo7/NIbxMJI7/9mibzY0/gu4bXGBppR3b16Y0tW3kPWpPn1Cytckr6oOJscKByLIIQHJzjFWmofBaFYfA+ldti3n9B9xMbXKac+Q0iQhb1wgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbtKeFL9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oafF1Wkj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbtKeFL9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oafF1Wkj"
Date: Thu, 26 Feb 2026 10:58:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772099941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYam34fvx910nzxtv0zP2ACsjNjwt7ARQIEtWYy7sKs=;
	b=JbtKeFL9cdPIQli9XdfpGHUlRUhvSy+1UoKZzpP0A9RjaDuvQSBpI/FcQFO7M3HwIEo/Qi
	+fINqS1y0o+Gxpsl6HE7D4xJXs8KThO4Ax5qSptIIZBqHgFlEnN5Q+kerK2rKB/iTW3UUZ
	e0u80Pba6Ui8GYwmD5dTu9iY5l5m++QdlQABHNMneyWjteRR+awZBcmBp/xHxxS7GkAwzW
	GNvEE3Dcdw6ObilXCI/l4H/a6IHaRIyyaJ9IW/szfgIA61IzY07Aj/SiYJY91qZ6YKHfes
	iJ1DHMyktHU2auItiyBDVWnv1eywVFGTPznBK4bRsPsX8ox8Q9MqDNXhssdHfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772099941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYam34fvx910nzxtv0zP2ACsjNjwt7ARQIEtWYy7sKs=;
	b=oafF1WkjPRpOKkopI+HDb9u5sBu0wwK2Ap8/pDQ+prBNMQeVYA7gJpG20EVBS2zRviStRL
	Dtld4x/xhOoDb3Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH bpf v1 1/2] net/bpf: fix null-ptr-deref in
 xdp_master_redirect() for bonding
Message-ID: <20260226095859.hLxDgGdn@linutronix.de>
References: <20260224112545.37888-1-jiayuan.chen@linux.dev>
 <20260224112545.37888-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224112545.37888-2-jiayuan.chen@linux.dev>

On 2026-02-24 19:25:41 [+0800], Jiayuan Chen wrote:
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4387,6 +4387,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>  	struct net_device *master, *slave;
>  
>  	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> +	if (unlikely(!master || !netif_running(master)))
> +		return XDP_TX;
> +

I'm not sure this check belongs here as this is not bond specific, is
it? Also nothing stops the admin to put the device right after the
netif_running() check so it fails later but the race window is not as
wide as it is now.

The per-CPU memory could be allocated while the bond device is created.
I don't think delaying it until "device up" brings any advantages.
One creates the device with the intention to use it so the "up" is
inevitable.
The bond_xmit_get_slave() callback has the same logic. Couldn't this
scenario also occur to the ->ndo_get_xmit_slave() user?

>  	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
>  	if (slave && slave != xdp->rxq->dev) {
>  		/* The target device is different from the receiving device, so

Sebastian
