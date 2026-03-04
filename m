Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABD35AC32
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639952; cv=none; b=kwvhXNKh4jcR/2PZAcNHrFCSlMPtFVJ5vKt+/oqu5fTHoctWD4ZQLHUZ0wluHqvtjCH7Uf7cAMX0gTxmoJrIWvE57AwEd/3YUsxjY1BGxCWoZvv3l8d8PDgg4XtRUI0hSrMuELBHcY2PcaJyJ5Jh3phzDorCB027n+CYxeVsBxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639952; c=relaxed/simple;
	bh=sRkO7eLIQ3gUqOEx4ySJKyymRH2K2LfoKGh++9p0oBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs9uhgEGYnnrZG58MRIp0EaDuCXdZ3zVZFo2lv+MIWeJOOqTpEcKar2xTxD1f6GB8YgxVyB9c/LAtfr9eX9A1fWY84X1lHDpS+yrrUDCVH9rorx1cUFyfWcPThy8a+ljlYR3CWM2R4J3l1mmHsN++YkrAn9NBO2LCun+kXTSsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mXI5I/zf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mXI5I/zf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso59309175e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Mar 2026 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772639949; x=1773244749; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HOSnZzfeSc3oCHq3PRnVd2F+xX7z1Nwp9tzlqrjRhhw=;
        b=mXI5I/zfrS2adwaPXcmneO/aI63Vx5Rfm0Hx48xX+bXuo75g59FD3/aMU0J05oCUcu
         FWJaaBSxQ32LhwvI2drbTKwtjHpCM06j05GSJJXQt80mfMiZZUM0j/MmF8++LtaMOX0G
         3986Z2mILkDbL1vDJnO7MF+fwK9gJ4/URRQeuAKMeh6X4ygPo+Y/f1XOC/X+WDpwerQW
         g/01YRiSVNaepZEY7io4G6BAhNL8oUVFew0sXoG/B9n4ncKXuVjfQw9iUnTcVAkw8Km2
         UcfiojhCRFWJqSJJQ1eQpDzmHRRjm14T8UvC9KoyYCaW1sNxGKAse8yVmDuRxqkwVP2b
         ds2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639949; x=1773244749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOSnZzfeSc3oCHq3PRnVd2F+xX7z1Nwp9tzlqrjRhhw=;
        b=ISja9lhzchYWU/+INZ1qZYknENtMWIz6tK0THVWeUBD3886M3FycrOiwESh1IWbFYm
         PuZivmCEZ0kFzDouzdzxHCzKxxjmJbCe9kuYUUNORSLHRVHG1jN3hcejXim7sEVcv8y1
         dq85wEQfzli9qiqxJvfIbTXd4IbiLchGFmgYBGUExWlwbT0ann+nLOpwccwvbNqDS49/
         0c/Kjnp6qhQ7fz13XnKkzvZ+swVmmiG/GF0LzPSsEnxqmwPhcor3nYI3CFOw0XmdhU1N
         fscQcl5o4EhQr6oZJycYnhjydNDjaiMExqVveyywMykFPg6R7ZJdT2t2U32Ozaks7YUm
         N5sw==
X-Forwarded-Encrypted: i=1; AJvYcCVWMUHMj3BagdbF/eJl8UnqlPojfx7pW7G+4EH6RRz09seqQK9/qjG90BB9js3972JRTdtTJ8xElNkQRT9ZIg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWc/mj3nOuZW264ZbdilBArowlss1yb9J+BadRncyVlJpcr0sJ
	eIt/fUR0C5GCiK22HzilfJTuN1VEPm85SvysKqMKg4/hjIlUTYIXA5deK7QKbkrxfo8=
X-Gm-Gg: ATEYQzxRad7yL8+6rHHF4YWf7jmcsSYpg1dWwTRImSUq2xa+0j+nEoOi1wrZ/ExdFBX
	11NipGiQ94glOXTcaU8jpwcP4wPRAn2+hlXdWEG/XcgHJnuq75E6qEFS8y0eMCGBJAc5gqXcANj
	tIw1xAFRCVWrdku7Zgubv1NAG0OpV8sTEwG1YafFnxHpFnQEvoz+0TxiZgCn+GFUcTohpee4Ru/
	/gyrV3Zu+4tIYQhIpStwjSwNOdLoYUyBNm2t6pkaivnEYX9zPuRmXs3CY59bCSwWRbjb+8AleY2
	CKaoY2wAYay+AdO4JLtHvEfNUxl3rPd7ztPyBh37bL/ISrBBzLXWEdl5COUhCfKPaM6h4lKF6pe
	3wQvH+LWKdixpwdNsj3NILVI7dfDFMf9gqEu/dhv8z+4KgZxl9FjEj6rV0zwGJmPyxnXSLTB+G8
	XXmTKt1HCzs9yDoKGt8gS9uS7edFuXNuTYq1dx+B7vssz4k9inqDowED6stg==
X-Received: by 2002:a05:600c:3b29:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-48519899381mr45743415e9.17.1772639948325;
        Wed, 04 Mar 2026 07:59:08 -0800 (PST)
Received: from localhost (176.111.182.151.kyiv.nat.volia.net. [176.111.182.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851acfa177sm21037355e9.4.2026.03.04.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:59:07 -0800 (PST)
Date: Wed, 4 Mar 2026 17:59:06 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: jv@jvosburgh.net, netdev@vger.kernel.org, jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
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
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <aahWymAi_CtRG0gJ@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304074301.35482-2-jiayuan.chen@linux.dev>

On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
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
> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> (ndo_init), which is called by register_netdevice() and covers both
> device creation paths (bond_create() and bond_newlink()). This also
> handles the case where bond mode is changed to round-robin after device
> creation. The conditional allocation in bond_open() is removed. Since
> bond_destructor() already unconditionally calls
> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> ndo_init, free at destructor.
> 
> Note: rr_tx_counter is only used by round-robin mode, so this
> deliberately allocates a per-cpu u32 that goes unused for other modes.
> Conditional allocation (e.g., in bond_option_mode_set) was considered
> but rejected: the XDP path can race with mode changes on a downed bond,
> and adding memory barriers to the XDP hot path is not justified for
> saving 4 bytes per CPU.
> 
> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

IMO it's not worth it to waste memory in all modes, for an unpopular mode.
I think it'd be better to add a null check in bond_rr_gen_slave_id(),
READ/WRITE_ONCE() should be enough since it is allocated only once, and
freed when the xmit code cannot be reachable anymore (otherwise we'd have
more bugs now). The branch will be successfully predicted practically always,
and you can also mark the ptr being null as unlikely. That way only RR takes
a very minimal hit, if any.

Cheers,
 Nik
