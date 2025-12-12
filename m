Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F482566F5
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556980; cv=none; b=EY/REXpbZY8mrZPER/U6pcs0OwDA/SUiOVQNjAVqldwfsDB85N1JvvmJsJZoipgkQzxKOFJoYrbiyoCU8usFvRxuyQzGah7cYdbtCmB6qMy0sCgip9saL2qjA9vldUKTmQ7S2Ukzr8pORVHOFrRE7urTAetm6iDN1lVGdvS5TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556980; c=relaxed/simple;
	bh=e2QFJCDiTu1MC5rOgdGGlN02BuoKkU9uEB6eycMMq/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Apt1CMWUQ1ob6rFwyk5QDBEbVHV8dJJWpKf9IMlhNjS0g3sSmqfQlUIxUcuTiuMiiRWMj1MPWuH0iHhxcfRiVhQQkJA/VChEXDECenp5A3ITO3wVxZf3GiWhNEcSLsvtMShFtGMtiapFX51nTPXwMmVkZf8SWJU9IzS71nIuNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ovlDOeGl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ovlDOeGl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786d1658793so13156367b3.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765556976; x=1766161776; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJow7Wat0dBZgcBjMOFWKCi/EiaoPVvKY0E1GqR6BaU=;
        b=ovlDOeGlRa4GuppsgeRlNYVxPopU7ftKdoeNFCb5ZJ85Kd2k5ul8O6oUJeJFYdqPdA
         GYqyP0Z3bQ/fICICiFg2r7GIkuJp/MeAku8pikSTvYLZpo0s4GCX9rY/dHBcheqEzxdL
         y2EgV8zXRz0w6+qDJ15fN8KH200W8Ae9zdTuZV6byP7iFrFhNmW2D97ccWFOUCbaiOek
         /ONzf1ByPyET6wtEZdhr+/qTbq1uYYRy2HaE0fwqrYwDfdzdscOZhd/liv+SdclSS7Mq
         DWPTYlbkD6GSvGP83PPLVOl9nimXqM/zlBw/cdhjkccS6QfiTMa5GMF4+9tanzAroevM
         IZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765556976; x=1766161776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJow7Wat0dBZgcBjMOFWKCi/EiaoPVvKY0E1GqR6BaU=;
        b=tdv0g3zT7eAqIWHfuvIpjoAFRUdv90jhIEWSf/9RTStdkZaonsBC92e+LSiFCNxwD2
         ihUW3x5yfUyakgZryUuf3VwDOAfgGfjN8jq57xobPSGdTd2x6WXmOB19Z4EuMNn9o0QR
         tndaJsveawHNzeIynQwVmv8GZTmoU9qlfTsw0purgqq0u+MJr6M9zOp6fL2EiX52Ka1i
         UWyDB+tFKHwOjdbMVdDYK4kzkZbUUNPBw08yWCHmlCNX3dLFXCiSTW6871fbYX0PdBlf
         bnxhtlPAQYEt8Gc8w4WBGJugrM2ucei0xnhsnfvP/ooemM7VaTiQAQw3AXAmeEzH/TsN
         c61w==
X-Forwarded-Encrypted: i=1; AJvYcCXi2kkgyYiuM0jyhVcUyXy7XyEzDThULiPrdXl2ZChdTk5t3kL+EuKuCNInRATKwLufVLUfZa3hq5lLQLW7Zw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygzrrb9AGUNyT9YXo14RiFVzfQXrOKauyM7A9RqqDPl4mnoLG6
	kkI6EgKvEkVkpSvLbikwCtIo1grDsVW8Dz7n+JXp3M4ed87k19DTO0AEOGaRRlR6gNut50S1Ilh
	y/0FqiUCSo47PXy6fY0kELIn7PftJFZI8Eh+1AVMd
X-Gm-Gg: AY/fxX7/+m5h/LYhsDwDuX8nHyy61VIyxmroOUvWboFtKSS0YTQsTNVy7iiD1+x6Roc
	73mIGr2xQ0uxRXUAvAjgr8KVac6FCNnk7OgjohIBHooOQYR39h1BKmB2ZVdwuK64OWCUicNoxp5
	B4lGmd3lLOQS9nceV0evs1l2iGgrunsnN71kv+yk3FlvcC+giAM9rqE2k4bP3t9XPMInRD9BU3V
	2vW8IM0mmyhNO7sE+vn9xqpKM4yK79GVx7ib+8+2d58bMBRFD2r1YxxGIY6gMlvSGh5elaxBhWS
	x9I=
X-Google-Smtp-Source: AGHT+IHaCND4QYQNKb0sfZyUrgjcJb4Tl1REioQfJr6s0KfYPAgTx2l5OrJ0PYZlIxMazIhPRs6SmTOkhIal+8HyztQ=
X-Received: by 2002:a05:690c:6089:b0:787:e3c0:f61f with SMTP id
 00721157ae682-78e66e22f5amr44620867b3.57.1765556976377; Fri, 12 Dec 2025
 08:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
 <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Dec 2025 11:29:24 -0500
X-Gm-Features: AQt7F2pc8asveroE2R-jp3qpZF_HQsuK7_ZalmtZEec2fHvVTs0GDCVOo6E1_d4
Message-ID: <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Ranganath V N <vnranganath.20@gmail.com>, linux-rt-devel@lists.linux.dev, 
	edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com, 
	horms@kernel.org, jiri@resnulli.us, khalid@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org>=
 wrote:
> >
> > On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > >
> > > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > >
> > > In tcf_ife_dump(), the variable 'opt' was partially initialized using=
 a
> > > designatied initializer. While the padding bytes are reamined
> > > uninitialized. nla_put() copies the entire structure into a
> > > netlink message, these uninitialized bytes leaked to userspace.
> > >
> > > Initialize the structure with memset before assigning its fields
> > > to ensure all members and padding are cleared prior to beign copied.
> > >
> > > This change silences the KMSAN report and prevents potential informat=
ion
> > > leaks from the kernel memory.
> > >
> > > This fix has been tested and validated by syzbot. This patch closes t=
he
> > > bug reported at the following syzkaller link and ensures no infoleak.
> > >
> > > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486ae=
e
> > > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > Fixes: ef6980b6becb ("introduce IFE action")
> > > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > ---
> > >  net/sched/act_ife.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > > index 107c6d83dc5c..7c6975632fc2 100644
> > > --- a/net/sched/act_ife.c
> > > +++ b/net/sched/act_ife.c
> > > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, st=
ruct tc_action *a, int bind,
> > >       unsigned char *b =3D skb_tail_pointer(skb);
> > >       struct tcf_ife_info *ife =3D to_ife(a);
> > >       struct tcf_ife_params *p;
> > > -     struct tc_ife opt =3D {
> > > -             .index =3D ife->tcf_index,
> > > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > -     };
> > > +     struct tc_ife opt;
> > >       struct tcf_t t;
> > >
> > > +     memset(&opt, 0, sizeof(opt));
> > > +
> > > +     opt.index =3D ife->tcf_index,
> > > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> >
> > Are you sure this is correct to delimit with commas instead of
> > semicolons?
> >
> > This already causes build failures of 5.10.247-rt141 kernel, because
> > their spin_lock_bh unrolls into do { .. } while (0):
> >
>
> Do you have access to this?
> commit 205305c028ad986d0649b8b100bab6032dcd1bb5
> Author: Chen Ni <nichen@iscas.ac.cn>
> Date:   Wed Nov 12 15:27:09 2025 +0800
>
>     net/sched: act_ife: convert comma to semicolon
>

Sigh. I see the problem: that patch did not have a Fixes tag;
otherwise, it would have been backported.

cheers,
jamal
