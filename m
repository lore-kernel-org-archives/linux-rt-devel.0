Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DC3101A2
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765816043; cv=none; b=WRaP1J/+NxwAbGA9nF2Dq6wOlFTEeILBziQzY06U8LWQvvIh5+3++BRLgXuuvRiaM7xu+NF6LKkJAZnBt+DnVr/RYKiFDbzycqypchjFCX7+CMdYcu8HBaGxAEJnscYMGInr+sQpHdX2smv3P3U4+1/1YPEII/cgUlQGbM17jQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765816043; c=relaxed/simple;
	bh=pGfGkm/LJKhlHj8QpkNFdNobVUFr7n+CQPnxy61rcfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuM8Qr9H2LOkBiLWhWDtdXeC6G9UFtRcziefrwnn1zaV2ajpBQBQVxPglfTabBIuu9Sqw3XSEU9fYI9j8jgyDvZG//Zl+ipal/M5isGM46Pb8nIBZatFqccem1RTKX81XbWH7QRro9dKNfSp9fBTVC4FGhdSoCyPHIKAdLLTHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OV1+s9t9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OV1+s9t9"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a09d981507so15007835ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Dec 2025 08:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1765816040; x=1766420840; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeFjW4GGBlfUil//ONawh35XqY0NMR/rqexb+Jz1U8Y=;
        b=OV1+s9t9cgz3SuMHmLztv5rZWjkRLP3HDrYBo5JrNVuDiWSV1TqqzUBRnigAWycMVe
         OR76i4+WodnUGm6hZGe/ig0x9CvS8MTLpyNqaFJwiWMN/hbfGfVUG/2EviVxx7an7zvN
         fe+KOaWLK6NBW8QBBRQLDWFIFFYvdoM4oyfHhPS52adbzfrXrXiuNnVd8aSrDiN5oqEE
         jZYesWGewH8EtseAzatKnBq3sL5DR/WRkNgNHZGYde1W8//FZ9v5M9IH+wMFr1MjWUJa
         zBAedZGnRZumoXDxE1luuen9ZBNodZ8OW/NL6PRapfqLjauD0XYcDYFS6rGia9TcyHB7
         v8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765816040; x=1766420840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eeFjW4GGBlfUil//ONawh35XqY0NMR/rqexb+Jz1U8Y=;
        b=tszm6VP5baXj12I/kNuiuJO33vVm/1bUtK7rDqkuvfQ/JWiTVOlgprTh+74tLmNdyg
         jBynVZ9wuuMh1G+uZqAarV1pqThh6N6HyZ9kZ8uOWq09+b6B4x+Aw2RSLym9bdbNYH2z
         Osd6OioMlTpoEu8vPkcuoU1s6PGdD5iwpYK5VGOwjB9JCa4fD2dGW0WrpG+NJIXos4rA
         3m9PY/DORtsmG/mnxKIb+jcshM+mM5DHE22dj98NirKEHNL8KWC6gDG872JpdUOIvM+s
         P8Is0aR/9j8so/zjWf4KUq/24jWmOH82OhZIBgv5h3dyVBa7cl1/6EsBItKmSXbt3qRA
         8RvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJwOfpMqI3kYv20nFIm4JeI36b1ONYKoPJeEQZemGqqTow28m+VZ/g7E1wy0cSSyCH8muf+MhU5au9muCM+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvSTz1845fAtNnJ1ObtZIo1Enb5HN2vv4zmpyoEmiHwJ1PQBI2
	e0EX3bsb5lwvkUqkdDslTLUpqvC3ow2KodryDoww0BWhlsROXMB7oNfJTyb5TW8xMiCawn6VuxL
	W4DWIk4CPwiGatlICrWupCsjekg9MuWn0XskCK51D
X-Gm-Gg: AY/fxX5+Ew6r85z1wfDTx/WYyagQ9aW01adxl2gRf+BJ1awFirOrKoHbXGAP9i2QQqZ
	zk5rl976npJOCdNhgXlMBZGctqQmjGiuppSxJ5PQYyRsD7YLRDxzKvwjtknSKNYEiQXqD9vijO4
	s5VrR06HoUzAo4JU2joxuVU/xljimo52BKYYVt6SdFwuKg1O0aYeJ9Yip1Sy0XgywWYWlkvwjcW
	O415CDjzEEtX1y1kvj0w9NGUAXYvOnQ6CIS7fJsW9pagtgC3QEdbb0VIGGedYQkvX+vZ0wi1OLF
	vMM=
X-Google-Smtp-Source: AGHT+IFUVGYJxDeOj/+7z2Sw/SnjfxffqQt8jBtVOKRWth8gPUTjMl0KDV8NE/zl2q1+LXxUhP1x5cGN20SnRcoqe3s=
X-Received: by 2002:a17:902:c94d:b0:295:6117:c597 with SMTP id
 d9443c01a7336-29eee9f1eb6mr160256245ad.5.1765816040355; Mon, 15 Dec 2025
 08:27:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com> <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
 <CAM0EoMmnDe+Re5P0YPiRTJ=N+4omhtv=r3i5iicav8R7hg6TTQ@mail.gmail.com>
 <CAM0EoMneOSX=AMe53hQibY=O6n=KYnudAWfVtUdOf8qc_Bmw+Q@mail.gmail.com> <3kwhg36anlckq57bez25aimvyj@altlinux.org>
In-Reply-To: <3kwhg36anlckq57bez25aimvyj@altlinux.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 15 Dec 2025 11:27:08 -0500
X-Gm-Features: AQt7F2qOz_HulbV6PMgGMsTzSxb-3zDgxkIjNkh0vPROCEBMB_qv8gXlxJpj1fA
Message-ID: <CAM0EoMk+5z0uiwdjvm6Fvx-RWOy0hWJrM4C6iPnCKv-Sh=uk4g@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
To: Vitaly Chikunov <vt@altlinux.org>, stable@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ranganath V N <vnranganath.20@gmail.com>, 
	linux-rt-devel@lists.linux.dev, edumazet@google.com, davem@davemloft.net, 
	david.hunter.linux@gmail.com, horms@kernel.org, jiri@resnulli.us, 
	khalid@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 4:38=E2=80=AFPM Vitaly Chikunov <vt@altlinux.org> w=
rote:
>
> Jamal, and linux-rt-devel,
>
> On Fri, Dec 12, 2025 at 11:29:24AM -0500, Jamal Hadi Salim wrote:
> > On Fri, Dec 12, 2025 at 11:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> > >
> > > On Thu, Dec 11, 2025 at 7:54=E2=80=AFPM Vitaly Chikunov <vt@altlinux.=
org> wrote:
> > > >
> > > > On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> > > > > Fix a KMSAN kernel-infoleak detected  by the syzbot .
> > > > >
> > > > > [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> > > > >
> > > > > In tcf_ife_dump(), the variable 'opt' was partially initialized u=
sing a
> > > > > designatied initializer. While the padding bytes are reamined
> > > > > uninitialized. nla_put() copies the entire structure into a
> > > > > netlink message, these uninitialized bytes leaked to userspace.
> > > > >
> > > > > Initialize the structure with memset before assigning its fields
> > > > > to ensure all members and padding are cleared prior to beign copi=
ed.
> > > > >
> > > > > This change silences the KMSAN report and prevents potential info=
rmation
> > > > > leaks from the kernel memory.
> > > > >
> > > > > This fix has been tested and validated by syzbot. This patch clos=
es the
> > > > > bug reported at the following syzkaller link and ensures no infol=
eak.
> > > > >
> > > > > Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.co=
m
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=3D0c85cae3350b7d4=
86aee
> > > > > Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> > > > > Fixes: ef6980b6becb ("introduce IFE action")
> > > > > Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> > > > > ---
> > > > >  net/sched/act_ife.c | 12 +++++++-----
> > > > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> > > > > index 107c6d83dc5c..7c6975632fc2 100644
> > > > > --- a/net/sched/act_ife.c
> > > > > +++ b/net/sched/act_ife.c
> > > > > @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb=
, struct tc_action *a, int bind,
> > > > >       unsigned char *b =3D skb_tail_pointer(skb);
> > > > >       struct tcf_ife_info *ife =3D to_ife(a);
> > > > >       struct tcf_ife_params *p;
> > > > > -     struct tc_ife opt =3D {
> > > > > -             .index =3D ife->tcf_index,
> > > > > -             .refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > > > -             .bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > > > -     };
> > > > > +     struct tc_ife opt;
> > > > >       struct tcf_t t;
> > > > >
> > > > > +     memset(&opt, 0, sizeof(opt));
> > > > > +
> > > > > +     opt.index =3D ife->tcf_index,
> > > > > +     opt.refcnt =3D refcount_read(&ife->tcf_refcnt) - ref,
> > > > > +     opt.bindcnt =3D atomic_read(&ife->tcf_bindcnt) - bind,
> > > >
> > > > Are you sure this is correct to delimit with commas instead of
> > > > semicolons?
> > > >
> > > > This already causes build failures of 5.10.247-rt141 kernel, becaus=
e
> > > > their spin_lock_bh unrolls into do { .. } while (0):
> > > >
> > >
> > > Do you have access to this?
> > > commit 205305c028ad986d0649b8b100bab6032dcd1bb5
> > > Author: Chen Ni <nichen@iscas.ac.cn>
> > > Date:   Wed Nov 12 15:27:09 2025 +0800
> > >
> > >     net/sched: act_ife: convert comma to semicolon
> > >
> >
> > Sigh. I see the problem: that patch did not have a Fixes tag;
> > otherwise, it would have been backported.
>
> Thanks! I will pick this for the local builds. But, perhaps, someone
> should send it to stable@kernel.org to fix the older -rt kernels too.
>

+ @stable
Not sure if this is enough. Let me know if @stable needs something more for=
mal.

cheers,
jamal
