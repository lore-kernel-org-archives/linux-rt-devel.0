Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B64938A712
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143375; cv=none; b=Jhe1l+Os92xggyDIJ+IrxeAj9H5ZjW6uewk66hPa/8r5Ol52tQJyPgrVVwUOzcNnfRLtuWjChSGa14mJBq480xXkXnPtYBtKPOowJB2/cXnE89bLadVMbT8CJrA4yI3sy3/yf+UZ4uVz4tt8Wl7PAGr5/Czi5L4gvG11nzoHsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143375; c=relaxed/simple;
	bh=Zr3qcMn4OLx1slxxG1q/v6XHjn/W58Jij9qVOShgcro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYgjwCNk8earXw4O15LLOKtCk8L9D88H/AoG6QVzmBCFXmOHvTQpHpt9inbtK0qlMRywzlFpkB0xvoVdAB73CHdFr6xKhT0e0AEVlYtWtDs4+EY4HmTg+DAQ0W/P20KBeBKyLZi7AAkjIAajNxcdV4piQFpXzUfjiMpQe4UVBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BESZYtkV; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BESZYtkV"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-466f00535cfso1998103b6e.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 04:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773143372; x=1773748172; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRz2iGuRS5c9gUYKqTban2ycHL3n1P/vxXJWakDhtNM=;
        b=BESZYtkV5nLSBe5sxY1V8jwAMfwnYqrOf2mrI6UiMZ89WvCDX0DQbp1gUyEF25QiZs
         wWyekjz9N9igglQEkybfnRfg6er6f/LL+J/NuJswJokdFnxBQ90iVjKhBp8sv8/tSuux
         ROymxYZvlxvZkpJ7NNJRnF3aVh+2Tq5S24pnBT6gbWznaJdKCIvblKEj/ThJ9J4ogJly
         txGEktk9tM1rT5Gff2aiXcDbYmHKFpIWZ1sCdihfBNXVB3MAPU92PfNGwbULCR3WWdiE
         eHhjvUvE/ioPx3d+CRUlgx3miW8K1xg8SJIJT81Guc80StOIQ171Pm7ByRMsWXTM8f/M
         27oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773143372; x=1773748172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRz2iGuRS5c9gUYKqTban2ycHL3n1P/vxXJWakDhtNM=;
        b=F1DiO8BVIAGEG6bfKUluiKVcgq7zQhx3npjX+ctbiXtEijBqoEP9XMHePiO3M2z+9L
         SoGYLKecYgUU545EJW4PRWTR0GrB3EOO9YLyd8hsyMljZtNFu7QFU5jTU75Qzrz1h9ek
         w/S9JN8TDRzSq99zYmJisbQW41eeASuxH94T1Ru3RlasbIStQZWRWyr+crJ4+t7B/j9l
         CV4cYoRdGBMNC98lZNNuSG/D3wwZ8rBml2SVm6dBHlM5lWwkg+6J+rfMo8O/lx/8JPCr
         /QokfZaoICl99RtxHSGxyIXrqoHYB19b2ZcB1sfXoxdnYwXsJwitmpkaQlyG5Y5JtbFK
         hkpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgLkIAaxNIUsUvMPUdFT2mX+7/PEvqL9CoQk42U5v2+x4HIlw/x+4mReqG+at/NfC2ZQej9AWhQ74Nc5AXMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMvyE+CR0R2z2vzdALilSKD3FqxJ9wo+ZItKuV9Eer1Oc+dSBu
	tgWj4ykYxjB7Kg3duwcbGMEYnzSVwjZFLcru2PQ16twGpbnkJqG6jRs8HgNs7GZnjAo=
X-Gm-Gg: ATEYQzzf0dfYaNG0zTxH+xNO1Nk2PpwtrApA4CxIZpjcs3NA0ab00Ijgu8c2T9U8bMf
	aEaZBd92Od4WDJwm2p0UlZ2301CM/dGYYShI+VzlOc0zY2TYfIghEo35pGaH9SgcTXWDs4kUOQw
	UlOEcwwHehF54lDBKcfvR/ESNeUdkS5xZobK1/gUja1DJC5zhokNSv6XVNyYw5xozJEAqYJkOqg
	Z2oIk2O9xvc/uQi3WMJNrlEvqzkxX6uruqiSYZaakYLyUoOuBY0c11Pkkzx2u39cj+oqgdGBFLE
	arRGYaCG+AFygJRL+CvRyaWT8ZtCZCyj57GJbUkIi/xn+DP0cRV7/2WBrrlxaXWkS+uOazKYGCo
	tki3nb+F2fqzdxTQaGMivEo+jRFxFoI7E7HiV6MZT/KFXm1o7eKbaKvDExuW7Kkvl94MRkDjLlo
	MbaubmvY43QTeTJFl9AZMJ
X-Received: by 2002:a05:6808:171a:b0:45c:a040:e53c with SMTP id 5614622812f47-466dcb1c40cmr7605844b6e.32.1773143372180;
        Tue, 10 Mar 2026 04:49:32 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfac3472sm7496849b6e.15.2026.03.10.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 04:49:30 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:49:25 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abAFRbJNinhN3O5v@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309030702.128520-2-jiayuan.chen@linux.dev>

On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> when the bond mode is round-robin. If the bond device was never brought
> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> 
> The XDP redirect path can reach this code even when the bond is not up:
> bpf_master_redirect_enabled_key is a global static key, so when any bond
> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> interception is enabled for all bond slaves system-wide. This allows the
> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> reached on a bond that was never opened.
> 
> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> never opened), fall back to get_random_u32() for slave selection. The
> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> publish the pointer to the XDP read side. A plain read suffices for the
> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> under RTNL lock and is the only writer of rr_tx_counter.
> 
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  drivers/net/bonding/bond_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

This is Jay's patch + the unlikely change, looks good to me.
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
 Nik

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 444519078da3..b8ec87625ce3 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4290,9 +4290,11 @@ static int bond_open(struct net_device *bond_dev)
>  	struct slave *slave;
>  
>  	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> -		bond->rr_tx_counter = alloc_percpu(u32);
> -		if (!bond->rr_tx_counter)
> +		u32 __percpu *rr_tx_tmp = alloc_percpu(u32);
> +
> +		if (!rr_tx_tmp)
>  			return -ENOMEM;
> +		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
>  	}
>  
>  	/* reset slave->backup and slave->inactive */
> @@ -4883,6 +4885,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
>  	struct reciprocal_value reciprocal_packets_per_slave;
>  	int packets_per_slave = bond->params.packets_per_slave;
>  
> +	if (unlikely(!READ_ONCE(bond->rr_tx_counter)))
> +		return get_random_u32();
> +
>  	switch (packets_per_slave) {
>  	case 0:
>  		slave_id = get_random_u32();
> -- 
> 2.43.0
> 
