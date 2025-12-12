Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581123DEB6
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556797; cv=none; b=BMJUkhm23Ui3LWSZc0Pp+ktSSPXNc/2kD5rwPALSJS6o9CVB8wj/uvCUUop/rf6QPZ8xe3psy64J7j2awTdXFZQaHELbHp5aGtSDWzK8N35iNiIGydb/jolFmmfvVOglw1I3MxEw9BZ+wcNAeZAawGWTb/VXPTFci6EWi/DJob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556797; c=relaxed/simple;
	bh=mWZ66NIH1czvwOY8VhKo1zGPjmO675aRWP8Xq0BdjAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScqVP5rkPPEv8XHogRCKjN80APFbpU1IuFsUE3+eEttc9zwa0PZGg0QDk9/kmP2TmC9iJTXizIDocaw5muYrtt5UVSjCdczyNsB2gs9EpzzkP/KP5EGtTfSad9iaYX4sphMlYyeSDS3DSbltfxIlX88xOt9ZGkKZ8w9yLcI33aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0qIXgua3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0qIXgua3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e239baecso9275365ad.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765556795; x=1766161595; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDAxQ1Ir8FP4xWW6w5X333ka+DlpMoQla6BYdhqIoH4=;
        b=0qIXgua3iiMD6CEv/sb88e8KBY9ajPMKtluMJNUIkCt+SezKYL/Jd37tTfxnvNOLwg
         tXXVC1fU+NHuLFp26ajC8KXhCg7/wPyS1Khl1VgXEyd1IVCxUfEqXBh5VE78Duuw/wr7
         oh68SEdX4lrzSoja1YchLYxUrC3RTN5oSvzAi22mpgeZXmGHfgh7rEhmtlg2asuNL6Al
         bmVK0U8n4g48fUJjf6GvOS6XsHtnwQx0rBBw9ay5ZPQGbqxwMH2tU3J3U94SKE7Xt1tb
         nD/iTbcuipB4+u/+tHnYCxPV7vV22W4xdaZUPSsigjLsm4UTHqNs0HCWYXXy8nSUw3f5
         47nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765556795; x=1766161595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDAxQ1Ir8FP4xWW6w5X333ka+DlpMoQla6BYdhqIoH4=;
        b=I8duugdCKoz03SBtbdj2giX0LRUvkQnHyOMlpXcFDFjv6Xx5HUEkHJVqaTkNoNVqHH
         5BzRow+6uURz2m478CJig0KE/MMiCVoPvAKVz622eAPMBqjT7F6zNf1QTvlaJfxO058X
         G3P66yNHyzx/Y/15k379AnUbGSEe1ZbMGY46VEu0A55F6MwuNvNDmguTPE2GCnSzzhoW
         PPszVAqhZ7iHnon4hCjNhABuKeEYBnYz7NXrFLSdq4Ml759YW1edCxao+8n70JqrRgAQ
         Ql3Cn2j1EMbwZRI6JEYZ0RugaWoVwTakE8YuYC/Y0qzCPCM5udOECAy02i6aBhJbYnmK
         NWdA==
X-Forwarded-Encrypted: i=1; AJvYcCVSPv9iOU3GH/EVOc531nxU2bmkDt354INpqWQuO2VZnAINPslpJ7sBGb3hW2oKGK/og1hD+HBcQZ7DdpucEw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/IkVnuIEGzCHM63sLMRgZZWlgw8pQyj9P9Nm19CDIHGXv7WwO
	+KB7PG+TYa4zeP17QtwtXt79MqPL229tvEMoA8hBVbp8REenWRMT3C18iP65f6sxaxcAJzHZLhb
	rG3V/i1YwbhDU35rSmpaSzebf3fQmOxnE/9L6NnZd
X-Gm-Gg: AY/fxX4AiQfpV25ufXVPtB9o49xXUbEIkmWeHs3uBai1ZhcwMiVsSPfSCEZqOpJyV24
	EZpodpeEQWfckNLE8EX6nhfJYBQ0q7TJjnc4S+jvyZoROBruzKBD/sq3i/Xmior2bFwFlfHdQNm
	0frgOIEpF4YhNVeAt19WvDsAAwREeVKpihkPTIfCui7VTE65ibwH3nG8dCUWDZG77NG4LsG80u/
	RGTytAOZbGd4yifqGcE0jOulWQT4kBO6UiqDiOzOhdRk1v/6r2FNDru7rhkx8ZWw48COq1WzNmd
	d1yxoo4bpmy/pQ==
X-Google-Smtp-Source: AGHT+IFiVGCM1mGrWhTz/en2jvkO+HvQ5tCflwK6dMKJcSCjAuD+CqVERmPVkZ9EUG1Il5KosbAEHBHGm9V9l4Kj18I=
X-Received: by 2002:a17:903:4b28:b0:29e:d5ad:4e98 with SMTP id
 d9443c01a7336-29f24d952admr30180795ad.13.1765556794831; Fri, 12 Dec 2025
 08:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
In-Reply-To: <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 12 Dec 2025 11:26:23 -0500
X-Gm-Features: AQt7F2ryRQOpM-Vb3oy4D-V5K1TIH0cXeA2qQazjeW7Q3ZLIFKmYG99dKaOvEN0
Message-ID: <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
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

On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> >
> > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> >
> > In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> > designatied initializer. While the padding bytes are reamined
> > uninitialized. nla_put() copies the entire structure into a
> > netlink message, these uninitialized bytes leaked to userspace.
> >
> > Initialize the structure with memset before assigning its fields
> > to ensure all members and padding are cleared prior to beign copied.
> >
> > This change silences the KMSAN report and prevents potential informatio=
n
> > leaks from the kernel memory.
> >
> > This fix has been tested and validated by syzbot. This patch closes the
> > bug reported at the following syzkaller link and ensures no infoleak.
> >
> > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d486aee
> > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > Fixes: ef6980b6becb ("introduce IFE action")
> > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > ---
> >  net/sched/act_ife.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > index 107c6d83dc5c..7c6975632fc2 100644
> > --- a/net/sched/act_ife.c
> > +++ b/net/sched/act_ife.c
> > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, stru=
ct tc_action *a, int bind,
> >       unsigned char *b =3D skb_tail_pointer(skb);
> >       struct tcf_ife_info *ife =3D to_ife(a);
> >       struct tcf_ife_params *p;
> > -     struct tc_ife opt =3D {
> > -             .index =3D ife->tcf_index,
> > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > -     };
> > +     struct tc_ife opt;
> >       struct tcf_t t;
> >
> > +     memset(&opt, 0, sizeof(opt));
> > +
> > +     opt.index =3D ife->tcf_index,
> > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
>
> Are you sure this is correct to delimit with commas instead of
> semicolons?
>
> This already causes build failures of 5.10.247-rt141 kernel, because
> their spin_lock_bh unrolls into do { .. } while (0):
>

Do you have access to this?
commit 205305c028ad986d0649b8b100bab6032dcd1bb5
Author: Chen Ni <nichen@iscas.ac.cn>
Date:   Wed Nov 12 15:27:09 2025 +0800

    net/sched: act_ife: convert comma to semicolon

cheers,
jamal

>      CC [M]  net/sched/act_ife.o
>    In file included from ./include/linux/spinlock.h:329,
>                     from ./include/linux/mmzone.h:8,
>                     from ./include/linux/gfp.h:6,
>                     from ./include/linux/mm.h:10,
>                     from ./include/linux/bvec.h:14,
>                     from ./include/linux/skbuff.h:17,
>                     from net/sched/act_ife.c:20:
>    net/sched/act_ife.c: In function 'tcf_ife_dump':
>    ./include/linux/spinlock_rt.h:44:2: error: expected expression before =
'do'
>       44 |  do {     \
>          |  ^~
>    net/sched/act_ife.c:655:2: note: in expansion of macro 'spin_lock_bh'
>      655 |  spin_lock_bh(&ife->tcf_lock);
>          |  ^~~~~~~~~~~~
>    make[2]: *** [scripts/Makefile.build:286: net/sched/act_ife.o] Error 1
>    make[2]: *** Waiting for unfinished jobs....
>
>
> Thanks,
>
> > +
> >       spin_lock_bh(&ife->tcf_lock);
> >       opt.action =3D ife->tcf_action;
> >       p =3D rcu_dereference_protected(ife->params,
> > --
> > 2.43.0
> >
