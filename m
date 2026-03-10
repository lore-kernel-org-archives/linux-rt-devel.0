Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A03F7E9A
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773144046; cv=pass; b=Oh9Kxso2OS37psLCKFLMpN8bZ335Cj8KVFeQe6ioCCA/pLAcB2LBZTVbmvS/CxZ0v7VRzhq11U0NhwaIzMheyEKoglElmoHmgRkrgp7UCxpmB+sJGcNrLbFOTS0dZsOTaLZIqA6GL0YlDzIx4BHGxsplcnFDQfR0jsMn/gCIGr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773144046; c=relaxed/simple;
	bh=tUzR/Nakid06crM4rvRZ4qf7nSgbgsUvkFMtzxj2kjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1SrqutDXIx61gHtY0OxFW4qslXPmBSp/7qevIN/MyqS28SEuPtiV9yKDemg2fqhzE8ZzndnUC7f51BRlyVgw/JHzNcMMceAob1lb0espaGm5kmydGb8yLoaJDidq1vVU0Pu1W5D4ZkyJIdVFD7pH08ZQh+PQix4YN108D5w/NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w6iDGWds; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6iDGWds"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cbb6d5f780so1288837085a.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Mar 2026 05:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773144044; cv=none;
        d=google.com; s=arc-20240605;
        b=Z3XogLq/X83ETbHDc17FpZCtuIj8Uf71l8HJh0f1fzXKxzRrHU20LRh3nRnTq6pkjy
         slVbRHlTADswfaFgjZmc9tEuB7LjmEoHf55OzpeSAdtvAJA7RmE+X8tQGcqQmR8TJZ+b
         zsHBUyxkgI+qG8hkANtfuVu4x8WnsBlq6bzKpcER//0hcyf/D8afv9NjPgfqHHWgBTre
         pRnieYeAeRLmpmYoPqhPGyrPxS7YYNrUGWuZv1Bc8G5+ZtrkfApA1VeMTJ+V9SNLomhZ
         d3Peih+ErHlLRjkIRtIM8a07XN+1tko9QWTmO/3NQ6elSgUhk9qnGsZtt2fhmymj0JEM
         4VvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        fh=HCyYfIZNPzgWC6FUDqYYksBDNObrQSoAv2SOGVXjwyM=;
        b=WUxmHHE7zWkXWOUOxlbylQ0XuVcV65Z+0C2U7PcREPCj7EgwYkUlPCMSKCpXrJ/CqT
         Nws17bVEmwq/73BIeWrgjYqaR4P8DJOh9tbk8yXu+im6DDNq+ntCD28Q6wzOYwud15Dd
         B9Hq57kRKPnNKx+XSnz1NHkawCKxbTXHbqduS1s8ltvyD7idiiawRaaSee4YXhLeuIJe
         Q2w4cST1SddqQReejKvAEHscfCzS+pRZlz6e/vEvSL47mahmFlKhOG9JrTWjD0ax553s
         TNrK6Rva4DWQsUJndoxp+dBz0e93hHUXj7k+Vh6n4jMxrj5tFgAqoVkC04orFOCtrmRB
         ZxWw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773144044; x=1773748844; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=w6iDGWdsXHbg/aLdGc4ajiirGcSahFE2T9TwrqAHOIVCPlcLTmshkzP9JpticFxFj4
         qD/9psVuhYM9Fqdv7enPv03Xd0vgZPOkCarQ1mZgc3JlNJl1+FNG6BE3UeMMjeg1yXZB
         mPbBpvzDZgVMxnMU8n7MQZ0J0cCGShrvxlfK7PqUwYQDpsyOX9QayuY0NJmGX3SfMyKr
         Fn51MPv0FvmEDBqa+7RitJjM9PIHhz/Tv4pC9TOyZZkwEqvPzy3XQvg1vty3mAMit61f
         6ZkQahlwhhc/xAPmQjsPYrcnqbKOckhHD9tt+qn2wHVt2YviTvmdjWFqizG0DeWT00aL
         d3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773144044; x=1773748844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KiPLCC30cbrBmI3zXpnvU6YblX0b2+xRJJpwJf5O1Q=;
        b=UELZ08lvOf8i46Hm2GHkTTeXLO5KadXMEb6SeWjsbJjr8b/tP0VEZcx+1fd9qu6Fza
         UmP7oBIQU1Y9cS1xUPSAGfsJQYNTa7aA2jHGsCK8KihEU6/PTOYbLVCxLG5j1/SJku5h
         9m7uB8acsnqoo3EQ6rcULtHe/sJ8nbep812Eh/tDN7BwwxhcxOj7NEbJuAvtIumDNUfV
         KhGtJSdBElmToxnB/3L8OyqtKMUvGOVEwtTrJe/qj2OdqMw5aazKTUOE/E22k/DRGxFg
         eONGiW6kw1vXJvSiPxwFia70eusZPdDdiy+s5hVjisGzLj8EKNq3V3H+R5HRJwwM6XA2
         ukng==
X-Forwarded-Encrypted: i=1; AJvYcCU5j+siWZO4LW8xp/RyycpfNivCvkd19K7ObQZudlOWlhy70MFW025tPvS6LLSuhiiIiycL6g1yZvxFnDzXnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkFa6di1uCYNu8mftRByTkKvGZEz40+J8Sm1WYKM6LKyHnrak2
	pnwSkivgMLCP426c9mIZgbxUJ2U4uavb3blN2NK5CDdd0LyzhBjGsEkFYrAhNhXtnjBdExNqtvm
	1T66iIvBKfnxjcZe/NYItKAmqohWgaHRdUIo8ZmKV
X-Gm-Gg: ATEYQzxTcCwPDKEc6itASHYnmoSIKWsaxXfX5SnT8witxY/QuFtjgUqghmIQ7VrTDpj
	Lma4dHoHT/kXqzc1usHb39C7N1PltnI6zAQvGrbaagVN1SMDIiOQ0N+I+2SFYz8PBxst93qWATE
	wGSandLX7Vog4veYeIcSrV6qtm1GxzzCm55ElU7HnIC/YjyHPnJETwxwYd3hsWqrzS3k2Daur+h
	ZRzecb2efPmutIpndC/x5egr6onX4nAyhiaXFKruxLNmMej4yrNebORWLW+z8Y1IEE4ZChR8rmW
	/Lpuxjs=
X-Received: by 2002:a05:622a:1a9d:b0:509:22ac:99ca with SMTP id
 d75a77b69052e-50922aca02amr50931071cf.36.1773144042675; Tue, 10 Mar 2026
 05:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev> <abAFRbJNinhN3O5v@penguin>
In-Reply-To: <abAFRbJNinhN3O5v@penguin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 13:00:30 +0100
X-Gm-Features: AaiRm509jDZ3zVYhIbanKsEufYLYkGg_h_Pmpop0SOjPwGN3a_7GxccBpHV9Ooo
Message-ID: <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
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

On Tue, Mar 10, 2026 at 12:49=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >
> > bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> > check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> > when the bond mode is round-robin. If the bond device was never brought
> > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >
> > The XDP redirect path can reach this code even when the bond is not up:
> > bpf_master_redirect_enabled_key is a global static key, so when any bon=
d
> > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > interception is enabled for all bond slaves system-wide. This allows th=
e
> > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > reached on a bond that was never opened.
> >
> > Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id=
()
> > before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond wa=
s
> > never opened), fall back to get_random_u32() for slave selection. The
> > allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> > publish the pointer to the XDP read side. A plain read suffices for the
> > !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> > under RTNL lock and is the only writer of rr_tx_counter.
> >
> > Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to sla=
ve device")
> > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@g=
oogle.com/T/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> > ---
> >  drivers/net/bonding/bond_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
>
> This is Jay's patch + the unlikely change, looks good to me.
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Orthogonal to this patch  :

 get_random_u32() typical cost is around 10 to 20 ns, I really wonder
if this makes sense
for the packets_per_slave =3D=3D 0 or 1 case to haves this kind of
randomness in the first place.

Perhaps we could use a

static DEFINE_PER_CPU(u32, rr_tx_counter)

And :
 slave_id =3D this_cpu_inc_return(rr_tx_counter);
