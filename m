Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB534396D13
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Mar 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799754; cv=none; b=h6u7wvi+MqsGXHbzCJuovDDRJmaZKPR0/D1+nYZAiR4hSAyoHnUk5kZPD+k6hS9efS17XGihGcC6lv6G/+1sstwRdTHh0qvR/gwJXbzbsMdDWAHdzmOjI6gWx6G8dvqe5l7anI8nw6IvZEmngqJL0h9CuGbHfnBirugG0Uyb5bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799754; c=relaxed/simple;
	bh=j/764L48Xx+7Zu6cS0Hd0T/spRfk3/nWHgaW8v7Xkv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkzdrzyf+YUWSj1exIE/Lj4YrneNcNBvsImyBiXKun6Rv5JsZld+4v7avjcjgim9YaytATeDTuy4vaPeZlP9UNX8HnaDhs4iU5netBSU1IHIdwvco1dCg7desCeIM8fTHaik6XFT1iXYfgJS5SX0zuTrSfcErHGF/xnNoXKhJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=c8M4BvHv; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="c8M4BvHv"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso5419728eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Mar 2026 04:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772799745; x=1773404545; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBRlKfOOjwlbHnXlngH96DL1JB+TDBbvPTEmG+WuzGA=;
        b=c8M4BvHvamOdwatRh4Iby+phmVxQMv0mKR0/7Si4fL5W8bJtPJCvAVI+TBa4teAo8H
         fNEO7/CCdpmxHwcQqpekA+iiVU9CB9hdKDXd+xfd9v0Rh8KEza/cNs5sbo7N78MSj79N
         X+II2NlJ3nCK6Idjn0j4sG6BOSAPB3pF1fxleTCL6hQT49BuaVJpVZL+uyVYq9Ijj7LL
         HIv/jGYgFJXMOlxRq9ugSRQJ+oUO9ddJMG2wSsyDBjlapj+oRi5z+wWN0fQxcliePhrL
         7ohFLabIUqdXO+T8lhiczww0cOpCK5Q2fvyHKIsZB2pLLeoE10x3nMQIIu4N6ykBOadi
         TPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772799745; x=1773404545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBRlKfOOjwlbHnXlngH96DL1JB+TDBbvPTEmG+WuzGA=;
        b=tyT1hCcLedEXsxtUsZFI29kc6H6vPjQ/pZ40cNEin/eaRP+luFqPoBlXzcxF2vEqJW
         41Yu61VcuDlaw3Z+3iNgEMXStUVmkJdc2aUzdg8KHpymqDR/8y6fImL1hjwaNQlhFnui
         Y3qy4apXlKgK7gksY/rB1TD4e+yACHNsg1ITnX6sDT4q4hdK4qaM1lmvH+XAhwzgwjsF
         ACeXShGuv6sVT5cEqGu9NrWqZH6gmgL1nLbnYz9/pCc9+8R0aZniD3YdB1jokvxatnCS
         8rA/sBqXsIWIcjjJ3gCNUerlKQjecMExRalNoERtruREh0fjM6h5iqH260v1hVAK8iOP
         kwQA==
X-Forwarded-Encrypted: i=1; AJvYcCVMT7aNoBYM8QakqZm6C3R/qjw9qgimpWT8GVfgx0Tzc6QCv6JGWTnmjlOGlPpXjqJjzLlt2zZLza4H6ZS7aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOe48Bv5cclQT5z9G0UHt12dwWWIB/elx9DAxDl98qTKwBXOBj
	7HV4j8ELuZw8kjIOghEDsZXPikLh63eFOBkau3ShtP8ZQzH6HDitYWhQOFOuZ2EMXu4=
X-Gm-Gg: ATEYQzyRexoxo2gS2kXT3ouay/i0GmrhmtdKbbfpHVNR9Oksb7IKlP8eOrRRQgq68ca
	JCv1TugXgx4lFZwMn3hT8LgNXaSdcwHscqkrE/l4GqZ+/w57HOeVeuFHyV8+1GttV9ViH4s96XW
	KTwXE3P87zSfGBsuwsjV9QSO1UxHZSM9xG14x07TFzJBCZ5Ke92KFjUWvkFYhUZa3sD826NfH0t
	zp78v+jVejAm1+X4273CwnjPANIFy+GpiugGo3HsB4U0LElOmogjiAXtSe4FFuzbJL4STIElkeg
	JRgWXNUSqVkmqrwe2J6T6NbhzGtMRhc+BmmOmuQqi7OWykcwQANWOm6Obfb5683EhIzXYeDDqdD
	DUBjMkEoXaqwS5oK06uXK4ovYovEqxMJ0ufKnFA50NB6Dm7S9JV/KFmYMf9Mno82djUDZ1sZI3a
	kkYM9r+ApY0aEjI13zZRCb
X-Received: by 2002:a05:7300:434b:b0:2be:13e1:d2c4 with SMTP id 5a478bee46e88-2be3e62e8c4mr2125798eec.12.1772799745038;
        Fri, 06 Mar 2026 04:22:25 -0800 (PST)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f807a30sm1015873eec.6.2026.03.06.04.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:22:23 -0800 (PST)
Date: Fri, 6 Mar 2026 14:22:19 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
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
Message-ID: <aarG-99qsXKgPMws@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <aahWymAi_CtRG0gJ@penguin>
 <1293120.1772645248@famine>
 <aahsuPt7cY8LxETN@penguin>
 <1356528.1772744631@famine>
 <e08dcb78a13fc69be07d28d032cebe3734797a3a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08dcb78a13fc69be07d28d032cebe3734797a3a@linux.dev>

On Fri, Mar 06, 2026 at 02:42:05AM +0000, Jiayuan Chen wrote:
> 2026/3/6 05:03, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jvosburgh.net?to=%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:
> 
> 
> > 
> > Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > 
> > > 
> > > On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
> > > 
> > > > 
> > > > Nikolay Aleksandrov <razor@blackwall.org> wrote:
> > > >  
> > > >  >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
> > > >  >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > >  >> 
> > > >  >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > > >  >> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > > >  >> when the bond mode is round-robin. If the bond device was never brought
> > > >  >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > > >  >> 
> > > >  >> The XDP redirect path can reach this code even when the bond is not up:
> > > >  >> bpf_master_redirect_enabled_key is a global static key, so when any bond
> > > >  >> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > >  >> interception is enabled for all bond slaves system-wide. This allows the
> > > >  >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > >  >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > >  >> reached on a bond that was never opened.
> > > >  >> 
> > > >  >> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> > > >  >> (ndo_init), which is called by register_netdevice() and covers both
> > > >  >> device creation paths (bond_create() and bond_newlink()). This also
> > > >  >> handles the case where bond mode is changed to round-robin after device
> > > >  >> creation. The conditional allocation in bond_open() is removed. Since
> > > >  >> bond_destructor() already unconditionally calls
> > > >  >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> > > >  >> ndo_init, free at destructor.
> > > >  >> 
> > > >  >> Note: rr_tx_counter is only used by round-robin mode, so this
> > > >  >> deliberately allocates a per-cpu u32 that goes unused for other modes.
> > > >  >> Conditional allocation (e.g., in bond_option_mode_set) was considered
> > > >  >> but rejected: the XDP path can race with mode changes on a downed bond,
> > > >  >> and adding memory barriers to the XDP hot path is not justified for
> > > >  >> saving 4 bytes per CPU.
> > > >  >> 
> > > >  >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> > > >  >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > >  >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> > > >  >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > >  >> ---
> > > >  >> drivers/net/bonding/bond_main.c | 19 +++++++++++++------
> > > >  >> 1 file changed, 13 insertions(+), 6 deletions(-)
> > > >  >> 
> > > >  >
> > > >  >IMO it's not worth it to waste memory in all modes, for an unpopular mode.
> > > >  >I think it'd be better to add a null check in bond_rr_gen_slave_id(),
> > > >  >READ/WRITE_ONCE() should be enough since it is allocated only once, and
> > > >  >freed when the xmit code cannot be reachable anymore (otherwise we'd have
> > > >  >more bugs now). The branch will be successfully predicted practically always,
> > > >  >and you can also mark the ptr being null as unlikely. That way only RR takes
> > > >  >a very minimal hit, if any.
> > > >  
> > > >  Is what you're suggesting different from Jiayuan's proposal[0],
> > > >  in the sense of needing barriers in the XDP hot path to insure ordering?
> > > >  
> > > >  If I understand correctly, your suggestion is something like
> > > >  (totally untested):
> > > > 
> > > Basically yes, that is what I'm proposing + an unlikely() around that
> > > null check since it is really unlikely and will be always predicted
> > > correctly, this way it's only for RR mode.
> > > 
> >  Jiayuan,
> > 
> >  Do you agree that the patch below (including Nikolay's
> > suggestion to add "unlikely") resolves the original issue without memory
> > waste, and without introducing performance issues (barriers) into the
> > XDP path?
> 
> 
> Sure, it's basically similar to what my v1 did, but the patch below can be more generic.
> 
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m08e3e53a8aa8d837ddc9242f4b14f2651a2b00aa
> 

IMO that is worse, you'll add 2 new tests and potentially 1 more cache line
for everyone in a hot path that is used a lot and must be kept as fast as possible.

> >  -J
> > 
> > > 
> > > > 
> > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > > >  index eb27cacc26d7..ac2a4fc0aad0 100644
> > > >  --- a/drivers/net/bonding/bond_main.c
> > > >  +++ b/drivers/net/bonding/bond_main.c
> > > >  @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
> > > >  static int bond_open(struct net_device *bond_dev)
> > > >  {
> > > >  struct bonding *bond = netdev_priv(bond_dev);
> > > >  + u32 __percpu *rr_tx_tmp;
> > > >  struct list_head *iter;
> > > >  struct slave *slave;
> > > >  
> > > >  - if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> > > >  - bond->rr_tx_counter = alloc_percpu(u32);
> > > >  - if (!bond->rr_tx_counter)
> > > >  + if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN &&
> > > >  + !READ_ONCE(bond->rr_tx_counter)) {
> > > >  + rr_tx_tmp = alloc_percpu(u32);
> > > >  + if (!rr_tx_tmp)
> > > >  return -ENOMEM;
> > > >  + WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
> > > >  +
> > > >  }
> > > >  
> > > >  /* reset slave->backup and slave->inactive */
> > > >  @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
> > > >  struct reciprocal_value reciprocal_packets_per_slave;
> > > >  int packets_per_slave = bond->params.packets_per_slave;
> > > >  
> > > >  + if (!READ_ONCE(bond->rr_tx_counter))
> > > >  + packets_per_slave = 0;
> > > >  +
> > > >  switch (packets_per_slave) {
> > > >  case 0:
> > > >  slave_id = get_random_u32();
> > > >  
> > > >  -J
> > > >  
> > > >  
> > > >  [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev/
> > > >
> > > 
> > ---
> >  -Jay Vosburgh, jv@jvosburgh.net
> >
