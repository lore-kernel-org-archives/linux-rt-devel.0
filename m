Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA98367F58
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860127; cv=none; b=FsAaT2hrK8csM4ka934FkKI3q5jnZjwByUfU+P8DKuovyz9OxkWRgkrX3uosgbILloZ7HxHa1AOIY8H1V7fKheLFR5Yoljn0YdODREeTZyiLJuEr0y9mTkG1aTKAQImZkaY28poAozvg4aNHuUq3+dlnvTFWUyJdtN1j6dqwI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860127; c=relaxed/simple;
	bh=rl5ttTB+5z7n8iszQNoA+98gom704EMdiWE3tNhYlMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVPHa88yt7pEx8t6OUFXB7O3XivghAr9WyB79ji2h+f3yggQTyjSbMb3+A2a22Kv/PGeEdzUdXOFqa6Qng8OHj/Tu1AylOXDXU00+i2DkYvxjt3ExymZaycFNR5ZGaITlWpThQvc4moNoNB7iwXK4KpUksCpdUuPeCvfN7Yw4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3HT14l1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3HT14l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776860125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypYS6lP+i3uWpu48VgfJsPtf+ABeQ7z9yqYNYwxZrNs=;
	b=c3HT14l1Eq+PpAfslRyQvEa+BSuxJFzFpqDcYrlh1AaFeWAO2aG2qdj5MshbZJUFebnkC3
	qXgRXTwmFxs9dfzh9zV5xPnvSEeGzUJmHpvUAw0SP8DZiRv+mYOtuzddGKHfqARNq3XBa4
	D5qQe3mGB6zCoFB2hcBFmNP+XKwYbOo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-x0XczmeDPtybSU0gw2OVtQ-1; Wed, 22 Apr 2026 08:15:23 -0400
X-MC-Unique: x0XczmeDPtybSU0gw2OVtQ-1
X-Mimecast-MFC-AGG-ID: x0XczmeDPtybSU0gw2OVtQ_1776860122
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b241be0126so109112895ad.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 05:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860122; x=1777464922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypYS6lP+i3uWpu48VgfJsPtf+ABeQ7z9yqYNYwxZrNs=;
        b=gJGYKtUAw3Tu93gafAcuUznSqKGhXHCqUNKmuw1o+SWupmpHvZoCTXPsw3jLmMy8X8
         F2NjoouWpe2tcvalwpc9clh8oZGdH1nartw4NywSqwuVr8M6N6ArM3oSURf/ylM3TKb6
         qwDUgH+YPx8jkvS5vU/hk5FmzTgOR6kHi6qYXdnnwzi+gNwV6X+Db13cY2Wbbyp8TKdN
         2/BVi8rfoyRqMrSC/AZ2cc2jCit4P0wvK8zpV46mtpVmHYxIMSTjxsfQkW8HiZAkzHpo
         Z8cz9y5/PE4nIqaQvPkEhT0GM9tHD6t1TNBmmD/jzHZKg8C2QZSn4sTMp189g/SZJFmN
         aurg==
X-Forwarded-Encrypted: i=1; AFNElJ/H5bUFa+pRUavismqDClVE1ZBgz9o6XaLwrJwAeTRXLdYEssMhym+GIxVzbMQz7du1GOkllSGvec7j6oc1WQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTHPvsjhXDCbEnQzrWKqXHipn50sve67hM4ooxopzNK3DqIE4O
	R+eRXXOsWkJ/38Uvs3Ab/tSqFtLxGh+6q5cEeCBI6JjMtxf6TCVXgkJhXfZ4L6bTDFQg3aKNa7m
	zzlenFIZNAH7BEtLTmA3wQuEIcOJSh3U4kAaAPqLkd5d8r7lXQWZ9P3F6syGKQWJnbg5kxMVPX8
	ojC6Mbc6Ls5K2bZMTv7GuRjlzatss1trGRg7CHMX7VfVaFi6H/SZs=
X-Gm-Gg: AeBDiet1VoC/3UD5EXjcD0WE6mbEX7vfU7zx2tvHDZmPaQmAE3CFqq8/QHPa0Ao4hOa
	SgESQTaKiz8OqxXoFx9lZOnZ5tziaNYVNsiRh+Vjkbur01zr4/DXVixFWyHQbvqKj2ygqaRyBd5
	1EHcoaufH7DG1Oub3t+Y23/oYYXi3tiQJ1t80Anh7KPyH72/w4N5OoV4u7AU5iLuVBFddtSTT4y
	8XQnPX1cK4Zzy7QS8SNfNQ8jm8Blfz/lb1DKgyVws7db5rpzOSfoBTdu2+iLY3nlyYz9LXGtcuE
X-Received: by 2002:a17:902:9696:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b5f9f7cec4mr160647625ad.21.1776860117156;
        Wed, 22 Apr 2026 05:15:17 -0700 (PDT)
X-Received: by 2002:a17:902:9696:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2b5f9f7cec4mr160647295ad.21.1776860116609; Wed, 22 Apr 2026
 05:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
 <20260421163207.48565-1-jie.wang@intel.com> <20260421163207.48565-3-jie.wang@intel.com>
In-Reply-To: <20260421163207.48565-3-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 22 Apr 2026 14:15:03 +0200
X-Gm-Features: AQROBzADzjA5yQaiPXjfyOVDpsiXeklWiS6dREnm1MV7hFEvZ0CgssEceXOhfeo
Message-ID: <CAHc6FU4VNTMJT3cVbaUr_gUSe4=wo2tNP2XT-XbxzqEyaRh_sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gfs2: move quota_init qc iterator increment
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0GvsOWHiKJDEFfRjS8hvyxVCm8sNqZUrW7bsSq8TMvQ_1776860122
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:44=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrot=
e:
> Move qc++ from the loop body into the for-loop increment
> expression in gfs2_quota_init().
>
> This keeps iterator progression explicit and avoids mixing pointer
> advance with duplicate-slot handling in the loop body.
>
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> ---
>  fs/gfs2/quota.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index df1cb99c3344..b9e13fe286be 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1447,7 +1447,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                 qc =3D (struct gfs2_quota_change *)(bh->b_data + sizeof(s=
truct gfs2_meta_header));
>                 for (y =3D 0; y < sdp->sd_qc_per_block && slot < sdp->sd_=
quota_slots;
> -                    y++, slot++) {
> +                    y++, slot++, qc++) {
>                         struct gfs2_quota_data *old_qd, *qd;
>                         s64 qc_change =3D be64_to_cpu(qc->qc_change);
>                         u32 qc_flags =3D be32_to_cpu(qc->qc_flags);
> @@ -1455,7 +1455,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                                                 USRQUOTA : GRPQUOTA;
>                         struct kqid qc_id =3D make_kqid(&init_user_ns, qt=
ype,
>                                                       be32_to_cpu(qc->qc_=
id));
> -                       qc++;
>                         if (!qc_change)
>                                 continue;
>
> --
> 2.34.1
>

Thanks, I'll add this to for-next once -rc1 is out.

Andreas

