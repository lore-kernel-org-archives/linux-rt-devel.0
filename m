Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1DE38AC77
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144450; cv=pass; b=mIMgPwVO4BrM3X6edMp8G/KTN8pbNNG/OvtrFnt5PkrNMqKhqHRIX40YUbcScrrz+ZaSd0jPIQIyTLqoShtfp6XRpHwjKM+jahtbp8+T+RtqOaSp6VQCxYOdjF2YsLCXPBqvoVCIUDNPTR9F5+XkADxOVky0oVqp8wkFyLko0fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144450; c=relaxed/simple;
	bh=u4ggnB30E8m47pn9MW6ki0gYz6mdnItwTDOiGvmjL+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bcPJrkHimhWH0ERPupbqRLOuo0+1jheqy7Y9yBOsOZYcVRet27CrSkpDx5BzNLxPQi3lDrIdTz7sH2NglmMGdhQ3MGmWSONFgG2n2uhRaPBxKh/EA9ML+7quz1K8B22Q9Y+z5AFo+L/bF/M60+iJ9tNJLGeiqwasxB9/5m+hicc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUxlA25G; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUxlA25G"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd7ecedf2cso250046885a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 05:07:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144447; cv=none;
        d=google.com; s=arc-20240605;
        b=SBZiAwkmCt5AU36qqNe6SgGmrPYxNZvfJ2voP4iif5bS9SxmcV4wv1WzT6hvHvhn++
         f7Cyh/WS89xGub8+vOfaKvWJugAhLzfbyURSuXE1esy122c0cMIjM/LN/Lb4++mYS7xi
         i0eiB4KoTf8j/GKd/WpRMHbgXIlUVADVv5PWu+nOhblJIaGOwYfjBILwKBrgP87/u2vv
         gFArZwnMkPma93aULki+zWTJjLn95hakpjchnMAXeymCO+M6WTr2gdcz/QowJyHD0mQH
         FZEtigRIECiyabi7h4GahLGulFloxUg+QRdqDNpPPshc6yixbr0XCuPpLcNZCCmRHMQT
         LQzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        fh=XlrlWCDu+XM/SefvYZstOooiZUxv85q8nP5q6VhBOX8=;
        b=SG6kGwQptiopvnTyst+UM/pgCaZ2++tLshigVQoorBQGjHa0URPo1H3sMxKm5I9AXq
         9s5FdmbB2AAFMNGFl85CkYGwCuYUrp3oVPhQht6oGn3f7ESOr7Sx+liy+bOlXq+OU2ni
         z05jcQigmsKhv+7bLDbZX3wNixm4FyZQTRdbovNkgZwLWycfLh0ic745jRTqj9RC4OeO
         uW+NDcvtFMOFg3xH5sy62i5nULNPXh9w1hzEvsexUbQ7pkaD4FnHl/JjDXLdbWewyL+V
         rvKTMtgWFIgrk1o+Kb1dEhQZwCmHdDu/CpGrWqaDEt9WI9B/Z45PduMLOQwopr31eQMR
         jWXg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144447; x=1773749247; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=vUxlA25Gkmgci4/UTKjXvb1dYiZJIfGa3ai0O7hrhZ52DGaNOdbne9t48Crl/wbn2K
         qWL8TrMMDz0MlNeTpW12s6fjVi+iqXM09o4X56b1JbU8vAfe1GnF19SCHRQDMlOAbAlZ
         7FSSYTt1j745Ikc1oU6XLoJaXPdzyg8tg6c+lS4LCYzoU/DYxU5zx5Qw1QZ3RcuO8xQC
         uer0dVdnX5SiIJO5L88X9sO0Y7hCUw+Ad288F95gNcLq556oJ+1Th5n5Ul8n3IK4j7gq
         11xiW5diEPHcMFNmRlIi/tf5ktudIWIts18Fd8PVmGWh3WvRy4+6mzw+ich8cXERV2CE
         VevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144447; x=1773749247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T8dYRLYkwn5kBNWo/bm2c1XHhtT3zdHO3dRrnUAcL10=;
        b=QbtIxmnzIglr32F8DVl5qKjn/ftAuYTaKU6+LFAovn+kRSWBtu0LGIddZA+lc9WPtt
         IpNPMWkboq9tifM3NXRGN79g0U233ENIdAWORTsekNFMWb/FIZvs/Tycpcm5/DRzUV3O
         K0wHkJWy6ZWdWB5m42ffont/3C8KG9rxzHSQ4uCR3ZVuzG+jcmAEt5qnE/mjxDTlee4k
         dI3si4LzyKrnutLT0q4noCANXTBHQq+RsQyGxJtfXHh4ZjHKi1NeCLUppP1YY15r0aCO
         pvIqbcrOjTIZbozc5fj7cSgX+D5z/LzvYutb70a0R32P9X9JhYXDIrlm7xq6xm6G1CL3
         7TpA==
X-Forwarded-Encrypted: i=1; AJvYcCUFLOMn0i38EE9XlXoAN5+BgVoWt0fCMTtsdQfsn7xMiZ+m+5auhiQ52n5yL2CZfq0kVfn3Vn4nUmPzgIkPaA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9ZCb2RlDsLNvHl0N5d9zRbVusd3r6o5s7mTQtuQB0x26KKp8J
	Kh3/LEt5Tu+SDrv2t6uEbl5XKTBntJdqzq+rXSvfOAVP667BVpGMGiFawPWtN0bRVdTzqrfOvTP
	AoyXQg+Q5xTBb6UPPV04dvlF6sO96pMa66kGMbSMl
X-Gm-Gg: ATEYQzx27pJsYA+6pUkId/3ssIYWIkPMk5QSrPzxG+5h5JGwptLDxkOIX7eXWlfNDRN
	YwIMw6e8A2Ih7Wb4aJ68rw95WqbCAfubfSkVq43gCjXK83v/+4GIh9wojNCOAuoT2omottUMh/Z
	NTRAZArtQKwt8P2jGdTtrW3ZqLPOcvpC7dgQNJpU+EH4CbazPpcJeWLf0jhQMnukp6QPXEC+Htk
	uvOI+V30KmgxIaXGAu2Gk+aY+dNH7J/5YO4OpycfT+ldwunGITK0fRkC+kmb5HY8ln4+WNge8J0
	b6UQvAQ=
X-Received: by 2002:a05:620a:4694:b0:8cd:8635:c04f with SMTP id
 af79cd13be357-8cd8635c58emr871773185a.78.1773144446171; Tue, 10 Mar 2026
 05:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin> <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
In-Reply-To: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:07:15 +0100
X-Gm-Features: AaiRm52YArIdW70Cdt1Zn-0xdLt1wQ__GHo4CYwly7pfLRtB5zsOkc7ncB8Yknc
Message-ID: <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in bond_rr_gen_slave_id()
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, jiayuan.chen@shopee.com, 
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 1:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
> <razor@blackwall.org> wrote:
> >
> > On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >
> > > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NUL=
L
> > > check. rr_tx_counter is a per-CPU counter only allocated in bond_open=
()
> > > when the bond mode is round-robin. If the bond device was never broug=
ht
> > > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> > >
> > > The XDP redirect path can reach this code even when the bond is not u=
p:
> > > bpf_master_redirect_enabled_key is a global static key, so when any b=
ond
> > > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > > interception is enabled for all bond slaves system-wide. This allows =
the
> > > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > > reached on a bond that was never opened.
> > >
> > > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_=
id()
> > > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond =
was
> > > never opened), fall back to get_random_u32() for slave selection. The
> > > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > > publish the pointer to the XDP read side. A plain read suffices for t=
he
> > > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > > under RTNL lock and is the only writer of rr_tx_counter.
> > >
> > > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to s=
lave device")
> > > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE=
@google.com/T/
> > > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > > ---
> > >  drivers/net/bonding/bond_main.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> >
> > This is Jay's patch + the unlikely change, looks good to me.
> > Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
>
> Orthogonal to this patch  :
>
>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> if this makes sense
> for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
> randomness in the first place.
>
> Perhaps we could use a
>
> static DEFINE_PER_CPU(u32, rr_tx_counter)
>
> And :
>  slave_id =3D this_cpu_inc_return(rr_tx_counter);

I also have mixed feelings about this patch.

We probably should detect that the device is not ready before hitting
something deeper in the stack.

Sure, a NULL deref is avoided, bu what happens next ?

We send a packet while the device is not UP, I am pretty sure this
violates at least some RCU rules in device dismantling.
