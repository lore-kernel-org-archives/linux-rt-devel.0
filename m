Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A0376462
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355548; cv=pass; b=MIPysQ4aOMifADedSlsb70Lal3+4yz0ZoRWmC89zxwlh+BfIW44BSVJ0ZYK6FpI0Z2fDum25Al77ejJxLj6w2Bx69XH/Vqo78IwhvF2gcRP89alRXKP9wve2SCn6i5+ZB54i7e8SvMNhm4QPichqZ0v3nltkBSBY2v1+9Ds1Ufs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355548; c=relaxed/simple;
	bh=js5SDLK+zkCRrpw2+cbIyuFJc9IaprQPZ/lIZpi0Edg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YINNRK9KEv1rp5w2DiCKNeXyKJNCPC4aEblB2NxQLT2a6S90pd6jfcIY897TrDcl4hlXSl7A79egcFAR8HFUvYCv9uggtK0OhKUFAv0KizB9JBXoeo5Ec3HGLGz7RAp8zyRpw0wAP163bksPsDm087aKyjvtePGvJrwUPUpG/G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXzRYjrY; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXzRYjrY"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so2910830a12.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 02:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355545; cv=none;
        d=google.com; s=arc-20240605;
        b=fx78EkVD/vZ/Te/4o5ENjF9/UBHTPv7xQ8jtC4CX4cTay9YFKVf5lr0KHaWiW0XMQl
         xuBuCaLvViVvcbbtMsCHgZvUOFcuh3sG+YOVjgedkj/64kqXMLTYLctl6vZ0Z/aQdNO0
         hw8BjJQ7ntBSqJPcqUXhO41xgkuHiuoGC2I99rUeXS6rL8u5/koxAIDUog5j5It4dIPr
         uBHvfal+PliGZy92rvoOabthWNVLV7SJ6fPkPpmSfTjjf9UaMIjwTczvj6rB7ADYh0o0
         TrKyy/RC8K/bey35mHvn7+KXmhy+5Ee4fW0dSHyQdFyScMOB7osSX+agdgVJrYy5/eSY
         sUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        fh=lCECzIdLJRVhn3jHTfr+aQ3xyxBAiBTGId5RWftCtVM=;
        b=FgD9JEjontKal8vgCzazw9npUIAfcqB/w+G/CRL8WfgAKFib9JjyBJv60DirdZFbca
         8ucdJ402i9xIUPwyYj6CXYqUgqFox8qcd9vNub7JMJBBh910hDSe8wODuCCVxcDUYPPN
         wxFzcLcMbL2AFE2/5JNFlKN+YIC6cTkwXF4ZbE/Qb5+ty4DkJOsXrieEMVKs11F1PhUT
         LGMFM//x6J1KSnUv0jI5a8S+2BaWwkA/7phuMHFwCFFpOt/1N/qhDnGKlKb/wZt5z6rZ
         PlzgcmDRVnXegmiBRXNzYkh/MJCRi0B8c7PbQdw1vzzNkNaxsml5mH2Hae5AVxn7Lasi
         ASFA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355545; x=1779960345; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        b=YXzRYjrYzmHz0iLKJVIeG44Y/T9/lLrwlzFgOGEnBlatLfo/nhrzS5LmPj5qwsdS4A
         /ZdC8njDF3rN3UQFm5bIkNytebSuq7nd7PKEN1wUwsohKlwui/WC02LH9smi9EQOPlWv
         eAE7luSfaG1lqAX4fecW3dTn9gMZJurW+QO+jVK/wRfBwJ/hVj5cvSQTjeH5r7PaDqUc
         VX1b8SOJMN37uTV7708MjoRkw0YmC57DTgeXtcdV+3C/vHspXqrAQW298BxubXIpLt+E
         W+2zLqs1dRUujQt3zI4dJ59OSSmJhqEYdEevPg/zCWcoxm7sft6Id5xjWkAVbtdRlOyo
         um/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355545; x=1779960345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        b=S+rvJ+Lre8VMzgnEapAjUxdeaOXi3hrGN5Nn45iKgWLHNpKDSdtS5mfWr2u/IJyqTg
         IEOvHK45bp+00rUh8sERCq1Jcj9IrzT1AgfWJw9/XP/3EO+MWIuuix+U7TaJcMOCMzfs
         WlYY9oBjx0Gyv3mNBITMnR7A3X3I13g2wfUMReg5RW1Ir6JdpCImgqaL7Wx5slyNvIHq
         AIM4qs5eLNHaavi4b/9hQtIiETl/iimtRBc2ULcjLhdNeL5MZGNjlkjS9q9JC+mQj9d0
         9KoIUUEv90oCq/iCK/76Xg0HXK5DS7P+2BU9GK0fmeHDrdvL6QBjIGLcqNmM3sVsBQil
         zXmw==
X-Forwarded-Encrypted: i=1; AFNElJ+ezWBe1SpEE3Eyf/g1WE5lqDQjMLKi6p893+/FJHFibqMCisBXMwiU5KGYv1V44Aj3xwPc46b2x+XgWKsgBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUTJrTu04Y1XxpkN9NFUbXZE9108jrgpFRyMw0GxEFYaxlij6h
	6jEU2+cX0xyzhoz41AuxIve80EabatdaeumTOw0I3VhiY25Qjks/9PMCw9d88NyvA8f5xUev6Qx
	ujEMbHbqiqhph4B4KPmSuta6qCCJSLvI=
X-Gm-Gg: Acq92OF3eKLS164ZhnkFuLu+JYxRk4G464EwGaGKPaFCD66t1zuXUGv5HJM1XACo2ez
	A/S1u+a+aUr1fgBaFDpJU+Xh6kQgIg02VeGKih84b5J4YER953e7Q/VLT0HdImolrF58cbEisGT
	XQX6YZ2/SZZXYyHpdc3eGuAirL4eegbxbnrqzlu35O4TiJX6GeLvqFMxPmweF/z5upsCcmBANRQ
	X04L6Rz8gWMvSn2fXrYVzXg04xcmfO0g84wZAI//jshPGs8KncTpktvMMDtZR72JCLA5bXIBPsf
	zLSd98/rbC2xOi7eptjmClclEt4O+cN+Kxn8XwJkbOPykvh8tw==
X-Received: by 2002:a17:907:86a2:b0:bd5:7c2:70c9 with SMTP id
 a640c23a62f3a-bdc15f2bc24mr113789266b.47.1779355544910; Thu, 21 May 2026
 02:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa> <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
In-Reply-To: <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 11:25:31 +0200
X-Gm-Features: AVHnY4KJNdKYQyfq9dcrIQyWHKYMB450aGPW4UBSN6VH-WfCBVPg7E2sdrdWSX8
Message-ID: <CAGudoHHaEFbft-SmPV+yTj6uMvNYWRQNYAWDP2x_sS=BcvesqA@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:21=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> > On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> > > Christian, can you fold this in please.
> > >
> > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > index 771fc31a69b8..8f17c0abbc95 100644
> > > --- a/fs/filesystems.c
> > > +++ b/fs/filesystems.c
> > > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> > >          * Did someone beat us to it?
> > >          */
> > >         if (old && old->gen =3D=3D file_systems_gen) {
> > > +               spin_unlock(&file_systems_lock);
> > >                 kfree(new);
> > >                 return 0;
> > >         }
> > > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> > >          * Did the list change in the meantime?
> > >          */
> > >         if (gen !=3D file_systems_gen) {
> > > +               spin_unlock(&file_systems_lock);
> > >                 kfree(new);
> > >                 goto retry;
> > >         }
> > >
> > >
> >
> > Even better, I got the above fixup + some polish listed below:
> > - removed an extra space in newlen calculation
> > - the WARN_ON_ONCE case needs to free 'new', not 'old'
> > - there is no READ_ONCE anymore in filesystems_proc_show()
> >
> > goes into the "fs: cache the string generated by reading /proc/filesyst=
ems"
> > commit.
> >
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 771fc31a69b8..712316a1e3e0 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >       hlist_for_each_entry_rcu(p, &file_systems, list) {
> >               if (!(p->fs_flags & FS_REQUIRES_DEV))
> >                       newlen +=3D strlen("nodev");
> > -             newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n"=
);
> > +             newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n")=
;
> >       }
> >       spin_unlock(&file_systems_lock);
> >
> > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >        * Did someone beat us to it?
> >        */
> >       if (old && old->gen =3D=3D file_systems_gen) {
> > +             spin_unlock(&file_systems_lock);
> >               kfree(new);
> >               return 0;
> >       }
> > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >        * Did the list change in the meantime?
> >        */
> >       if (gen !=3D file_systems_gen) {
> > +             spin_unlock(&file_systems_lock);
> >               kfree(new);
> >               goto retry;
> >       }
> > @@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> >                * generation above and messes it up.
> >                */
> >               spin_unlock(&file_systems_lock);
> > -             if (old)
> > -                     kfree_rcu(old, rcu);
> > +             kfree(new);
> >               return -EINVAL;
> >       }
> >
> >       /*
> > -      * Paired with consume fence in READ_ONCE() in filesystems_proc_s=
how()
> > +      * Paired with consume fence in rcu_dereference() in filesystems_=
proc_show()
> >        */
> >       smp_store_release(&file_systems_string, new);
> >       spin_unlock(&file_systems_lock);
> >
>
> So it was commit 36b3306779ea
> ("fs: cache the string generated by reading /proc/filesystems")
> which caused the problem. If I had finished the bisection properly instea=
d
> of cutting I probably would have noticed this...
>
> So I tested
>
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 771fc31a69b8..8f17c0abbc95 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(v=
oid)
>          * Did someone beat us to it?
>          */
>         if (old && old->gen =3D=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 return 0;
>         }
> @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(v=
oid)
>          * Did the list change in the meantime?
>          */
>         if (gen !=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 goto retry;
>         }
>
> with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boots o=
nly though (next-20260619
> crashed in 2 out of 3 boots without RT)) but I get this warning on every =
boot:
>
> [    2.793416] [    T331] ------------[ cut here ]------------
> [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mutex_=
lock+0x586/0x10c0, CPU#17: (udev-worker)/331

Just so that we are on the same page: if you take the -next tag as is
and revert the "fs: cache the string generated by reading
/proc/filesystems" commit alone things work fine?
