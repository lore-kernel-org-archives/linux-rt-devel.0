Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3212E325488
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771493850; cv=none; b=sFqLq0yZG70p2yCyz8VDW+dvFLf1nLlANJiyxa+G+GCTutYa0nKzHoCX2S/ctXiu6XdXNGBX7StyFAjMGNJuzyQ2HPOE2wcXhhVmAzzkvViflUdwdgGtVUG61ibsbAWY/Ovy/FIwfF1FqGasuXxBlJ15c0rZLrHWNS2PgNBveOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771493850; c=relaxed/simple;
	bh=NPSXSi9b9TxxjHxLZpUcRJKWrGeG6PeYyngk6bejy0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8nFV4nBFuqnGuNItFZTCwsEE1vx0+WWDmjtQDzYFF23IwnedprKMku1mQLpsq6/i4OPqli4z31MHMuL1v46LEymEtZ9WLNq/UD1Pu0nRUL6rQCfQLrMY/eutg+MepsRRUu16zlTmZZwO84ev7zHI4HGQMknIWMe/U+ho0iwHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsvFkcIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsvFkcIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771493848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
	b=PsvFkcIwA5EjxvHHIrGVbqD6gWpxXl/Ju2VvX0rKbE7jdHEL5VCW0JTWuH0QpXh7fmxz29
	Ho2TIfA4AV3J6pQ47g67jvRNHSMkGN5uqN5Lc+aYkt2eJVW5eveyv5bI4tb+GWECcqOF+q
	9hgSTT3lqCz88mKhfoUl81AyBVOBJlw=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-Jdkz25LWMAyHDNMX-qSPmQ-1; Thu, 19 Feb 2026 04:37:26 -0500
X-MC-Unique: Jdkz25LWMAyHDNMX-qSPmQ-1
X-Mimecast-MFC-AGG-ID: Jdkz25LWMAyHDNMX-qSPmQ_1771493846
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5fdf09ad2cfso977082137.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Feb 2026 01:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771493846; x=1772098646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hyo2TDLSBnm8RCUIl2jfZS6nvGZOMbEPzxbuvA9Ganc=;
        b=Qp0el+DnjW9S5r2e5IcIXS45TmqmqOj37b9KM311aR7fME/6PzQB87jVfD5EghcfwR
         Zfiwi4yeJMUWJ4nrM8Khu+ry8qNm/ztqf54wEXmnf7K7+FJSwekI9jnceEaqtH11FzZV
         AI3yrHAvH6gzcQAQq12Js8tFqHSYADoHAxdvmCjBZXlulkntZ7wAik1uea0Nfi09SmTw
         lvbdrQtu0nOefkn0bd8o5GJbKnUK/9MliH3Kd7qBKtCBzONmJ5pPFCotdFWfTPMb14xF
         Mhux5Ioy0hmFMHcjhFRWJkO1Vz3NTSD+mTpo79QNJXFl817Uq9di/VVFrdnhBDBfB1ic
         EVXw==
X-Forwarded-Encrypted: i=1; AJvYcCXxd4tIns2LrJWHOWAcg9xRsdw2WjVDY6Tv/2e/BDOtZoOKAO+dPkTtiiIGjWB5Xm4XipesA0BmvK2WkC+0tA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoxS8iSecQZai43IafYMPllvjpI2NKMMZHAAo3cAQNLAwWca30
	rXEewYNgf9hlRU4iGleGmtV3QHU59ymJ0zueB+h3E/bpIoVLJOq70tGmZ/B9zkAkeWtZUSJmCk6
	lu3DbBeNwkyg4Ls7RvskgoGA/EW6jrXbWZfFNMpdYcHda+9zMO4oLFLNgoB/Fwn6i61Y5r9zP5/
	r19QlhdSVkElGUGsKfD3d9WUMwid67XWRfYfldhlGFquw=
X-Gm-Gg: AZuq6aIKAoS1MBjlGOrnsivO0cys+3fLq0eNkPOidI65kcxi+KDccqK2sx0ZUEigBiz
	5Ulczdx4qVAAgbVDMnp5kwPEiTtHejOEZneooOhijRsGZOJvWF+thNrfRDoJWmxCwM0pFkcGD7L
	QeQvudqqpqblHRE+nIACk2Flovweq2fElm7z+cU/GT88BLkA++C3zZhyYDPLQmLbIKPpLy0S6ch
	k58FGPItRAiv2ZOyuUshARt
X-Received: by 2002:a05:6102:d89:b0:5f5:5a45:ac5d with SMTP id ada2fe7eead31-5fe2adbe968mr5841260137.17.1771493846215;
        Thu, 19 Feb 2026 01:37:26 -0800 (PST)
X-Received: by 2002:a05:6102:d89:b0:5f5:5a45:ac5d with SMTP id
 ada2fe7eead31-5fe2adbe968mr5841242137.17.1771493845743; Thu, 19 Feb 2026
 01:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <fe346c26386a4fc85cfa27e669dffd13191e7ea4.camel@ibm.com>
 <20260218195738.49204-1-ionut.nechita@windriver.com> <aef4d7dbea2fe3301ac922a7a189ecc8c93314d5.camel@ibm.com>
In-Reply-To: <aef4d7dbea2fe3301ac922a7a189ecc8c93314d5.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 19 Feb 2026 11:37:14 +0200
X-Gm-Features: AaiRm51GEnBgOsF3e_sOTAwsw9WqobfzJ2VFTTJ0IIRFH_IIWnKfwycB6hq8Blo
Message-ID: <CAO8a2SjKw53e0PqGCBKOakpmMgJH_Ka7_o2uijBhcr5S7vEdRw@mail.gmail.com>
Subject: Re: [PATCH] ceph: add timeout protection to ceph_mdsc_sync() path
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, 
	"ionut.nechita@windriver.com" <ionut.nechita@windriver.com>, 
	"ionut_n2001@yahoo.com" <ionut_n2001@yahoo.com>, "sage@newdream.net" <sage@newdream.net>, Xiubo Li <xiubli@redhat.com>, 
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org" <clrkwllms@kernel.org>, 
	"superm1@kernel.org" <superm1@kernel.org>, "jkosina@suse.com" <jkosina@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ynCVA9QJQm6CylXPF0_MpCAqMpKOAJdxTNIfTR-GiAU_1771493846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tend to agree here with Slava, I don't support any Timeout as a
solution before we have an actual RCA.

On Wed, Feb 18, 2026 at 10:04=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-02-18 at 21:57 +0200, Ionut Nechita (Wind River) wrote:
> > Hi Slava,
> >
> > Thanks for testing and reproducing this with generic/013.
> >
> > Looking at the stack trace you shared:
> >
> >   ceph_mdsc_sync+0x4b4 -> wait_for_completion(&req->r_safe_completion)
> >   ceph_sync_fs
> >   sync_filesystem
> >   __x64_sys_syncfs
> >
> > This is the same pattern we see in the original report - the sync path
> > blocks indefinitely on wait_for_completion() with no timeout. In your
> > case it's ceph_mdsc_sync() hanging on r_safe_completion, which is
> > exactly what patch 2/3 ("ceph: add timeout protection to
> > ceph_mdsc_sync() path") addresses.
> >
> > The root cause may differ from the original IPv6/EADDRNOTAVAIL scenario=
,
> > but the symptom and the fix are the same - these wait_for_completion()
> > calls in the sync path need timeout protection regardless of what cause=
s
> > the underlying delay.
> >
> > All three patches are now also on LKML:
> >
> >   1/3 - libceph: handle EADDRNOTAVAIL more gracefully (v2)
> >   2/3 - ceph: add timeout protection to ceph_mdsc_sync() path
> >   3/3 - ceph: add timeout protection to ceph_osdc_sync() path
> >
> > I've also added more details and debug information to the Ceph tracker
> > issue at https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__tracker=
.ceph.com_issues_74897&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMz=
c8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3Dty8gR4OjrwFXUQPjG9Dm4EapzO4Hwyj7aAX6I=
NwulJY0GjoU0pTf7khYkXwrksDT&s=3D3fOX8o4od1TodhJw8SHCNjR4huXJS6VsRFYD6791DWM=
&e=3D  - it might help with
> > your investigation.
>
> Frankly speaking, I don't see the situation of blocked thread if I am add=
ing
> debug output. It looks like a race condition. And I am not sure now that =
adding
> timeout is the proper fix. Probably, we have some issue that needs to be =
fixed
> and timeout looks like workaround but not the fix. I don't think that I h=
ave the
> IPv6/EADDRNOTAVAIL case on my side.
>
> Thanks,
> Slava.

