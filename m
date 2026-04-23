Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C187029BD91
	for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776929031; cv=none; b=j2ve0R61pk0/pFKj67VRVCuD1gzaeSa8KSA/KNsSUl1fr4pXvLzt7Hf3pQyzMAQpHOE2iC4loGEy98B/P4XmEOuWPfgCHWup/ZxqoFYRex/+O6MeGTILn7Hbvk1NrmbyRiJKy2bHvHVEd+2Kgf1PXjC/Fv8MSMC/Y7JK6Tbkgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776929031; c=relaxed/simple;
	bh=ltZGGpPSa0HhQECRftLDQ460uSs9j4JoAIdKxDd18xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiuzHSDdaC4H81AoeAPjSZDHasAIxdcnrnt+i5RZLOTUVnioeeV0vWSZaC1DDwywFkFh7GW6jWYpj7qIw7vIvW3c8zy/yQZHIVMYRYSBdcllQIzpwgts2Zr85k5aEPxNVM8mcE/QzoReoa4GYqPcBY8SlO0q4ihPrkY5kppp+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGjyTF4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGjyTF4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776929028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WabLTUulfk2gxS4+FSYtEJ/yqourTno2JhWtJJOQPck=;
	b=dGjyTF4e5szmepr50nhXvv/6fztKHyFabTISusvJt5ocgOdpBObYbvNI/uTjgbqCZ4v3G7
	cYInRylhQHnnfUDDjpUb250k7Db9VctgxNKnDEyu38pMlJ6r4izmGyv6YCS/8ycB+oBSKF
	+7q7WD/y/Y8vu/XLMDIQ4MWNQccbBMo=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-XyBStiw6Pw6eFB50lZyI1Q-1; Thu, 23 Apr 2026 03:23:45 -0400
X-MC-Unique: XyBStiw6Pw6eFB50lZyI1Q-1
X-Mimecast-MFC-AGG-ID: XyBStiw6Pw6eFB50lZyI1Q_1776929025
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79064868702so140211347b3.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 23 Apr 2026 00:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776929025; x=1777533825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WabLTUulfk2gxS4+FSYtEJ/yqourTno2JhWtJJOQPck=;
        b=IWZ/IcpmfilX/yh1WRkIX5VS4FrmB6q5rY9Gm3QaqA0anjKiszsAAQLgyUuUMSXOeF
         4sMVgxUBU9JLEaMiVPzrc/GgIyDnDpTlClorsTSm3pSNQqtEpeHM+L6SP/slvQEAosmW
         os3fYozxT9X3Ty9LZeML/AmRWnix4QjMO3CugW4/ma0bWcr56mFSV/Tqf2HDf4PsOiIi
         HQsXBp7OsIGnRk10NE1XCzFireJuuxL+WY9i/s64N/qXlbZNbJy/zOmGGs4FEVrjLj4y
         dyu6WDYgn6vvVphm9/15/nFrfWbClMo+wZPzj1EU7/CgvJgOpQjjgoltVcwmBirW04Zx
         2ljg==
X-Forwarded-Encrypted: i=1; AFNElJ9Fd1sit2KIVFCwsQK69AruoSo67E+JXMQk1/I3eoEmE2RuzsEIORmrRBBhykyScp7xgGWfOSmggn4F9D6veg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOgZXxMxM7Z/7VJMzDT0jdAceE2WLsmGzF3wjOOfUD37kDBazH
	y3q9ulreU53sItYHCwZgLfrIuiUfw1SnDwxFI2q1NYwsEP712Uw+WD95vSEpG0gJ8RuTh0UjFYP
	J6XEDyVj5QK81Z/Z7In7gZNE34A73Q2TpZdsZCPIZwvmwIVb6YM16vhyZ+0IUWaP34IFoEo+xQw
	wGQDzgYAs2GiWBisqa3bgv+9DdBAou8VmenMitg2ne0nI=
X-Gm-Gg: AeBDies/bbPwlwUGeBfBEc8uUh623JLqvn13MMKF52ywv6lCYlfBHwWCyqXf1tz9i1Z
	Sp9IjobzZisCkeGnXI3Ka3Qawh+yVmPrVYemU0vtCiTJfzU0TTBhfCcLYg2aFDPlptZOvmYY3Kw
	6mYoD0JBpc0YjkvMIW7qQ1ce7k8AMbmnfnQ795H3Q+jkCSvVmLuypqJ9tAt1zVLBeyG0UhC66wi
	WPvtdpzDE97ffs4KYVNhbQT2i/t2xxQa8PIGn4c/SnAGgK9h9wk+3qZgHplt7JProp4dP8HME+4
X-Received: by 2002:a05:690c:c4f1:b0:7ba:f6b4:3550 with SMTP id 00721157ae682-7baf6b43b80mr150284087b3.45.1776929024865;
        Thu, 23 Apr 2026 00:23:44 -0700 (PDT)
X-Received: by 2002:a05:690c:c4f1:b0:7ba:f6b4:3550 with SMTP id
 00721157ae682-7baf6b43b80mr150283857b3.45.1776929024334; Thu, 23 Apr 2026
 00:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5Zx4jQ9_c7wtJeeSF=V895hwCa47OvK0Qm_oFGK1YbPg@mail.gmail.com>
 <20260423133934.118970-1-jie.wang@intel.com>
In-Reply-To: <20260423133934.118970-1-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 23 Apr 2026 09:23:32 +0200
X-Gm-Features: AQROBzDbBcmEoeTHIEcuAp3NDqtCnbQ6TVIIR7Tik8-7O-p27QK_BYGe8WCpuOY
Message-ID: <CAHc6FU7DLZrunqxQkY35voRraBxUG=wNucn_3s7LqF1BdrxzCg@mail.gmail.com>
Subject: Re: [PATCH v3] gfs2: fix quota init duplicate scan
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xu88Dkt6eTe-vaGu1dacaX5en2iFFqguDuO9AqSuq3o_1776929025
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 7:52=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrote=
:
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
> v3:
> - Keep spin_unlock_bucket(hash) in the if (old_qd) path.
> - Drop the extra spin_lock_bucket(hash) before insertion.
>
>  fs/gfs2/quota.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 5290865f27f1..934397248fe7 100644
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
> @@ -1458,7 +1472,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                         spin_lock(&qd_lock);
>                         spin_lock_bucket(hash);
> -                       old_qd =3D gfs2_qd_search_bucket(hash, sdp, qc_id=
);
> +                       old_qd =3D gfs2_qd_search_bucket_noref(hash, sdp,=
 qc_id);
>                         if (old_qd) {
>                                 fs_err(sdp, "Corruption found in quota_ch=
ange%u"
>                                             "file: duplicate identifier i=
n "
> @@ -1467,7 +1481,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                                 spin_unlock_bucket(hash);
>                                 spin_unlock(&qd_lock);
> -                               qd_put(old_qd);
>
>                                 gfs2_glock_put(qd->qd_gl);
>                                 kmem_cache_free(gfs2_quotad_cachep, qd);
> --
> 2.34.1
>

Thanks, I'll add this.

Andreas

