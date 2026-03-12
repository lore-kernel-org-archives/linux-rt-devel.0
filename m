Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154A39B973
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313585; cv=none; b=BLYHUYw3P76oYZ5Qp/WMjJT8vN/kphgCcw+ElAjQ/d229qRWfsTlKwViGuub0PQE2tN70zb8UFPFAWOoVELyX3DCSoQbkbvaelM5N/XwtAte4ADEtMoigcBQVhpjelKAx3lXNHozSghYfXN655NAwKMkw2zIIxC9by2LKTwifrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313585; c=relaxed/simple;
	bh=/9J3tVGfkbfc2ZVBxryfqsIyn/sMRAL1gB1bZI9O198=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otUfTzMOsH4wvVw5bDkc3bUVQK8fOlujzgpAQm8eSRFwSd3qKUkbtOChOMbGJSitlnd4M1Uv/KK3rX4DI8/Kj+5SsyfPZlwtDq0VHPlDXcrID7Yv3fnApHuAt+aYD3G8OipUEVTLldkT4g4dxd5Y8BcuUI9YpmQ9lqDVkEzOuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=h7yxbqAv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="h7yxbqAv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso10379905e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Mar 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773313582; x=1773918382; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=h7yxbqAvQ9POhUtTyVUHdsT/Gc0WZ2Q6xoFXLA+wcqhBeI4T3sAdyi0un/vr7kjs2X
         n0i3piClt1M4LS/DWfKy2+PFW1R19DAQ7qMlq57vkBV1FfjNVMahx5uyZZlxfTNmgJUF
         4TYmrTKqaZzJLcdpeZBVbG0wlh64nsAbMFg3KE6LiixdMz8s57/7Cl5DJjamToIae6ko
         ukpFkZX3edJxLb+2s+obJiAZjBTtUjSvi9kboqV5F699I4UOJcM4jPVXkuWhPl7hm+PE
         CYYnFuyKxN2oXp+XRXWpfqf55XufIJOTj58e8ogBP570sBUAv7pB0UHcEiAWlrpG6fxh
         RZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773313582; x=1773918382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=MtLQi5xgAxtfNmAhgkUZLbuqGRgmBdn9eyAYBcP2dIN62jn05JE5sSFQfs5LBLygeZ
         dzJgQUGSChREBW6SH5FAtRzyCnyCYreC7WCYXrzh2JpP9awNDHHSBHJinWebzAWDpkxM
         BlxP7Q64SPpV0envAZ1VVblFDrQY92jxogDIidzfJZANLQwwG1Vuxi3LJABdXtzBBYaJ
         XRcCc1N5MXe4oepg9gD9mPi7euai42C9tFtFMbeRJKzmy0l6K3zqlrKmHb/K9UIBZ+Vk
         OceP+tYVW1GYTzmV/Y31z+tHld0cV4tcx8qpE3NKtSsW4Hsx7R0BqM7lkDcvUqnummjz
         yFlg==
X-Forwarded-Encrypted: i=1; AJvYcCXFfEt0sK25DuFw3q2LEY7TM7pSG6ZUy03FzFK/WjMVsTZ8tpo4p30IB10Fn2XFRcO+vgJKW5DhzbfehGYHJQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6wNSOEo+WBQDtqxPpWeRJKUjAoKq7He1ElmtvV81BsQRyYAOv
	kW7N4A2kpD9OcMPFHErF7HYru01kCboTpQXGLjweUhClAEigFX/O5XUMtjffqri5jBE=
X-Gm-Gg: ATEYQzzfQnNCBYYazHNjwiuIlH8NFitpAOiQb5cs+UVaImvrkhlHRXhAaAo+D7tq300
	zT6Ix32rA85vCwM/lcXEpTq6GoFSXHDYOzBWooOm/4AIUYR2Bc5OZvhbQKRFVwO9EwKsvxjE6fv
	XKAocRBZbhf0OArtwTBDPFU2o8abgnv4ceKIm3fg6tmE94BtwtTul1BmI/PKUoBH+Bl1p74utwU
	D6+thu4L2zg7vJnncfvfvA/OAFCRBV7AZznAyy5Q+MCSFWJ8GnsevkoSxkUbdyMsbrSZfUmStLF
	zfaHiSpV9XIcN3nuXjPR1hW4PZgs0AchsFh2r4E2Z6mTjpsC8bU5sWkP/a1F+eP2v8S2e0+CR4b
	9j+rhAgr2ytdd+SZcj5P9M2PnKwKF2Yldy8UDKb7yHz0oX3CCRqapAxAX3V/GXfz3XQq9bsYckN
	LiDlXVKfrpHxxXxUnEh2KMcWAUeyZWLChG+Kq3Bklsy8CoIe/nW7ficxf3/WqpTb/AiW/4
X-Received: by 2002:a05:600c:4752:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-4854b0c77f4mr96011415e9.13.1773313581497;
        Thu, 12 Mar 2026 04:06:21 -0700 (PDT)
Received: from localhost (176.111.184.239.kyiv.nat.volia.net. [176.111.184.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18ddedsm108978795e9.0.2026.03.12.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:06:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:06:19 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
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
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abKeK-w7K7xLuWAH@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
 <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
 <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>

On Thu, Mar 12, 2026 at 11:36:20AM +0100, Paolo Abeni wrote:
> On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> > On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
> >> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
> >>>
> >>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
> >>> <razor@blackwall.org> wrote:
> >>>>
> >>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> >>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>>
> >>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> >>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> >>>>> when the bond mode is round-robin. If the bond device was never brought
> >>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >>>>>
> >>>>> The XDP redirect path can reach this code even when the bond is not up:
> >>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
> >>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >>>>> interception is enabled for all bond slaves system-wide. This allows the
> >>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >>>>> reached on a bond that was never opened.
> >>>>>
> >>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> >>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> >>>>> never opened), fall back to get_random_u32() for slave selection. The
> >>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> >>>>> publish the pointer to the XDP read side. A plain read suffices for the
> >>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> >>>>> under RTNL lock and is the only writer of rr_tx_counter.
> >>>>>
> >>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> >>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> >>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> >>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>> ---
> >>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
> >>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>>
> >>>>
> >>>> This is Jay's patch + the unlikely change, looks good to me.
> >>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> >>>
> >>> Orthogonal to this patch  :
> >>>
> >>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> >>> if this makes sense
> >>> for the packets_per_slave == 0 or 1 case to haves this kind of
> >>> randomness in the first place.
> >>>
> >>> Perhaps we could use a
> >>>
> >>> static DEFINE_PER_CPU(u32, rr_tx_counter)
> >>>
> >>> And :
> >>>  slave_id = this_cpu_inc_return(rr_tx_counter);
> >>
> >> I also have mixed feelings about this patch.
> >>
> >> We probably should detect that the device is not ready before hitting
> >> something deeper in the stack.
> >>
> >> Sure, a NULL deref is avoided, bu what happens next ?
> >>
> >> We send a packet while the device is not UP, I am pretty sure this
> >> violates at least some RCU rules in device dismantling.
> > 
> > IIRC when the redirect continues, the packet should get dropped if the device is
> > not up (checks at a few places), but that's outside of bond's jurisdiction and
> > after the slave id is needed in xdp master redirect's path unfortunately.
> > I'm not sure it can reach much further, it just has the master dev's slave id
> > generation in its path.
> > 
> > In any case we shouldn't crash in the slave id generation in the bonding,
> > that ndo's only job is to return a slave id.
> 
> I'm sorry for the back and forth, but I share Eric's concern. I think
> the approach suggested by Daniel:
> 
> https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/
> 

That will work, I like Daniel's patch as well. It will add a test for all redirects
for master devices, but I guess that is ok. For bonding it will work because the bond
has the problem only while it was never opened (before first up).

IMO this patch still has value, because currently the code implicitly relies on
a specific sequence of events, who knows tomorrow someone may find another way
and again call that ndo while the bond is down.

> or the initial patch form:
> 
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7
> 
> would be better. To respond to old concerns raised there: the check is
> IMHO bond-specific, as control moves from the lower interface to the
> upper bonding device, and the code is under an RCU critical section, the
> device can't go away before the xmit is completed.

This one I don't like, it is not about going away, it is more about adding 2 new
tests for everyone and potentially 1 more cache line.

> 
> /P
> 

Cheers,
 Nik

