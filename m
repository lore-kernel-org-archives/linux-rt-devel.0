Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D113CE4BB
	for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859840; cv=none; b=Q+S0f5zbnuVrYWDYm55u0j2NoB6CpRFUVJ/tl7eerlYY3Sdq4+Fs0qioiK9vLCz5XGSHu29gu5QOs6emfdC67rjf00pWqY7dxla2SyiYapxgG8IXdYKVREgGhTO33e72Ta5l1frVcoXujzmnZA8Zai42JkZuynAY47DgT64ilR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859840; c=relaxed/simple;
	bh=KADdOErpPNuveLmLOPmTskuJjHNbSanIKSk3/rpNIwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBKmV0iiKJzZ537cLswUbiK1EydJRpYnoYiiG57HgW63r4Tkrau+V1G2bWkLTLq+3BMcD3VuYDM9V/X8YM3NJC0+qTsLb/WL+G/9dm7x7n+Yb3i2YtM1/Bh1CGL+6nShUPeKvjLOJL+tC7o8ZeC4p6oA4Q+zLytiDCn41Z4SRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRwiu9ux; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRwiu9ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776859838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r01gzGSMZ1OLeEQHZP3Kp4fLk35M3tRbC7hGVAlZKo=;
	b=DRwiu9uxMi8tKZc7GCuiBU9pSB8RrUf/kBmMIrCe+CpvdupbKGvct8DwiiDAPKdP0ELUZj
	LcaP+UL8yml1wp1WjDOs20OYZ0Ka4k7BkWjQdtPbHHBlUb9GMbBOCamj2CVcaZGiRlHHdk
	5E1ZymWb/+Ni1vO3yNWg5klcL4r/QBs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-nRHmy1TkOiS-CWGv689QHg-1; Wed, 22 Apr 2026 08:10:36 -0400
X-MC-Unique: nRHmy1TkOiS-CWGv689QHg-1
X-Mimecast-MFC-AGG-ID: nRHmy1TkOiS-CWGv689QHg_1776859835
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b242b9359aso52314255ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 22 Apr 2026 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776859835; x=1777464635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0r01gzGSMZ1OLeEQHZP3Kp4fLk35M3tRbC7hGVAlZKo=;
        b=RiPgAUc4MUjCmWzoNES+2lE9v3bkOk6lV1yWg1SHrbCHsHOalOR6V1csZJjqSXRzIA
         bJ8QtoHaF1XyVKtjNlhXNWFhYIy/8XxwNhSMlG/KlI3sNEGcbk9TP4IKXiZlhghK8W53
         adQ8Ixz2Tp7mDTJzw2GP6gF3ZrMGN02uhNSWtP0EJCU7zxkkn4JnP2lb7cJURZOQ2Lgq
         zG2iK6I/U2LvHo1Tqc/pS9YALfvjPlpKugoH5Jsj3vGBvcxLW7mUfRcTpJPp9lp6M2s6
         e4C4yTYukL/61rUC2nbuzmh0C9hh1NPQ9HgD7lI0g6/s4IBiAk1Xi6iwtEybHpinmH0G
         Fp7w==
X-Forwarded-Encrypted: i=1; AFNElJ/xF4TFWcjp+tuaKpwkGSZD+0hDg9VNfZHKhpxj7xpPrMqyv5SWirlzsDxzMnM+xbNwF3tuSXWOWHPar9jI5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrteGByTPhoY+H1M9+q58pEpjijj/H1SiTiOOSWmKVIKfh8yFn
	sHHGScx1SLCLuLFAEhtbRqNg4tb5f797NIDaudFWIBkoi2NHITzkQ4cg+xP6JZMmt3widaGofjD
	pa6Rn0hXQTj31rAEFS0KrUjvJOuIdFFv4l7PbI9Hwx2m68En5pvIN23F3ssjnEpJ9F1IVLkUN1Z
	cdClNVTKkxgc7LovSNmGVuuKILh54k0hr0cVMrE4DhVQvik9g1QXfOnA==
X-Gm-Gg: AeBDiesgyFkJGZ1xo/KKhYg5hfq9z8RfAJrxH6WKxnFdgVERNvm8bl54wwI8J/r8KDe
	OZpMyCOYSyUnQ92BuUcNwu4rNNfyF5bUB0GXZkE1pXGR4WFff7I6TTI093UBZsMeOYAjz8vA/af
	vepkAwKWGjhhvOmSyW2HG2BLtnw5hOQdKWqKkXHfBt00PxV7nbcOnJM3Q/7lefANfYnZzFixYCO
	zmef5d09ddUS4nFuuKQJYM+VITqzlMuCt+uo2FkLhCIWpvd+9TZRa8EBCRKLB/DEZY7uCVZJ0JG
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id d9443c01a7336-2b5f9f83117mr164229545ad.37.1776859834810;
        Wed, 22 Apr 2026 05:10:34 -0700 (PDT)
X-Received: by 2002:a17:902:8d98:b0:2b4:5fae:cbd8 with SMTP id
 d9443c01a7336-2b5f9f83117mr164229125ad.37.1776859834071; Wed, 22 Apr 2026
 05:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
 <20260421163207.48565-1-jie.wang@intel.com> <20260421163207.48565-2-jie.wang@intel.com>
In-Reply-To: <20260421163207.48565-2-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 22 Apr 2026 14:10:22 +0200
X-Gm-Features: AQROBzANUIDb16bJGw2lu_xPFN6pVbfoAM1FiM3YNu5k6u_48FuHomgFAE9Ikbk
Message-ID: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gfs2: fix quota init duplicate scan
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BpdkG5VTm0gKcgjpA0T_gxxsOJdyO_RoOWz7KqG955Y_1776859835
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

this is looking good except for one minor detail (see below).

On Tue, Apr 21, 2026 at 10:44=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrot=
e:
> gfs2_quota_init() checks for duplicate quota_change IDs while holding
> qd_lock and the quota hash bucket bitlock. That path used
> gfs2_qd_search_bucket(), which takes a lockref reference via
> lockref_get_not_dead().
>
> On PREEMPT_RT this may sleep, which is not allowed under the bucket
> bitlock, triggering "sleeping function called from invalid context".
>
> Use a no-ref bucket lookup in this path, then continue duplicate
> handling without taking a lockref there.
>
> Refactor gfs2_qd_search_bucket() to build on top of the no-ref helper
> so lookup traversal stays in one place.
>
> This patch fixes a bug reported by syzbot.
>
> Reported-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D642d0561f78362d67d3f
> Tested-by: syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> ---
>  fs/gfs2/quota.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..df1cb99c3344 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -254,9 +254,13 @@ static struct gfs2_quota_data *qd_alloc(unsigned has=
h, struct gfs2_sbd *sdp, str
>         return NULL;
>  }
>
> -static struct gfs2_quota_data *gfs2_qd_search_bucket(unsigned int hash,
> -                                                    const struct gfs2_sb=
d *sdp,
> -                                                    struct kqid qid)
> +/*
> + * Lookup variant for callers which already hold qd_lock + bucket lock.
> + */
> +static struct gfs2_quota_data *
> +gfs2_qd_search_bucket_noref(unsigned int hash,
> +                           const struct gfs2_sbd *sdp,
> +                           struct kqid qid)
>  {
>         struct gfs2_quota_data *qd;
>         struct hlist_bl_node *h;
> @@ -264,12 +268,22 @@ static struct gfs2_quota_data *gfs2_qd_search_bucke=
t(unsigned int hash,
>         hlist_bl_for_each_entry_rcu(qd, h, &qd_hash_table[hash], qd_hlist=
) {
>                 if (!qid_eq(qd->qd_id, qid))
>                         continue;
> -               if (qd->qd_sbd !=3D sdp)
> -                       continue;
> -               if (lockref_get_not_dead(&qd->qd_lockref)) {
> -                       list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
> +               if (qd->qd_sbd =3D=3D sdp)
>                         return qd;
> -               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static struct gfs2_quota_data *
> +gfs2_qd_search_bucket(unsigned int hash, const struct gfs2_sbd *sdp, str=
uct kqid qid)
> +{
> +       struct gfs2_quota_data *qd;
> +
> +       qd =3D gfs2_qd_search_bucket_noref(hash, sdp, qid);
> +       if (qd && lockref_get_not_dead(&qd->qd_lockref)) {
> +               list_lru_del_obj(&gfs2_qd_lru, &qd->qd_lru);
> +               return qd;
>         }
>
>         return NULL;
> @@ -1458,16 +1472,15 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                         spin_lock(&qd_lock);
>                         spin_lock_bucket(hash);
> -                       old_qd =3D gfs2_qd_search_bucket(hash, sdp, qc_id=
);
> +                       old_qd =3D gfs2_qd_search_bucket_noref(hash, sdp,=
 qc_id);
> +                       spin_unlock_bucket(hash);
>                         if (old_qd) {
>                                 fs_err(sdp, "Corruption found in quota_ch=
ange%u"
>                                             "file: duplicate identifier i=
n "
>                                             "slot %u\n",
>                                             sdp->sd_jdesc->jd_jid, slot);
>
> -                               spin_unlock_bucket(hash);

Why didn't you just leave this spin_unlock_bucket() call inside the if
statement?

>                                 spin_unlock(&qd_lock);
> -                               qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
>                                 kmem_cache_free(gfs2_quotad_cachep, qd);
> @@ -1483,6 +1496,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                         BUG_ON(test_and_set_bit(slot, sdp->sd_quota_bitma=
p));
>                         list_add(&qd->qd_list, &sdp->sd_quota_list);
>                         atomic_inc(&sdp->sd_quota_count);
> +                       spin_lock_bucket(hash);
>                         hlist_bl_add_head_rcu(&qd->qd_hlist, &qd_hash_tab=
le[hash]);
>                         spin_unlock_bucket(hash);
>                         spin_unlock(&qd_lock);
> --
> 2.34.1
>

Thanks,
Andreas

