Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FE437FF67
	for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784453602; cv=pass; b=agJZERsDw2rhHgDPHAag4Xz12XTU1t7Oa5s0K8nogwrTFyyidPWxcuYjgoA74jLejqSx80FJcZ+LL1DkEGNqmykN54PNXBcSMJLXVn9cAR3Cc8NWOesZf+B07rXulnNVgLwvT2XHCZ3tXoxSzWaG0hWKBXclGBpLBdFCIsBvlvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784453602; c=relaxed/simple;
	bh=Z10chkoO6YI36yHG+rhrUl8tGJpl9dz7+bTrE6cz/kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDoOM70bJriFtgh/z5Lf2fgN9a2ywetnCc6/JWVlEqiFouGFe0cQjDzRTAyiEl+LWzrhiO1eLrPHCvjqmNfVdiJbX8DC+398GXIpCWX+YFbDKDXEPYiio0pUQ2LMFPmyvT4AK/0VP6tYznmGc9EMwp0JQ/sks+SnU69NrgIz4Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfagIpLy; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfagIpLy"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-446f87b6de1so4272766fac.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 19 Jul 2026 02:33:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784453600; cv=none;
        d=google.com; s=arc-20260327;
        b=oC35b1IyTXDUGLVUDQMWkEf0tHiL20es2JY4wwKKI3e4g/WL0LXcutiq5JGBjz+6em
         uIrgxsKbLjh1sRwnNz6JHc7DEVyB1/+o6SiZem+UqLXBaluPdQD8oI0Akl13KXFtUvyj
         aI3q6uDLpi3oPwcuCIsldQH0VOJyCF6Qkxo2IsdWvo1gvB6ZBLcEFP47l9ZOpbv7FE0o
         qIlWSe1qrUBjaTyEltWUJfojMa4KKv3dsb+ajhLDMqOoG47j3e1HL9dOyq7AMOPBo0lp
         sMVtnroGKvpk6f0UPvdjN/JU6rYeiUh+kzhJogJbWjNxvxmaLr5D0k1uwFH6LkYKd070
         Lp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=th85pFw/R60Y/fI3U9L5PnkcKBvcHC3c0Lw2SKZ9e60=;
        fh=3bKHWJ12T8c2vuCADl369aTymMv9jzWtjCEmLc8Owdo=;
        b=X764b39e1/MWsVp+ADS10v/+yhZWPSpWBWlWz5p84uMvyHLe5Pr4StmWsvTZpaf1sw
         4oFT7FKbdx17TaEozjZZ8HIPWo4oT3DMPBivTXlsBtJJAHuMIurTWGL85dvE9uEwzE/j
         x4RMNQ+o2pY0It6PI84nBiOLm3yPXH4YsePjp7Tm1sge8XfZjt89mboElcVBv2m9KPnR
         yTlIPEQA+JRuCQMaLSEB8hkE/6e2p+I3Pdm5o1k5WTsNh9bO+qfw391noPW3Z3HcEnoQ
         D+W4uiLeR+51JdVciKuP1f6407bs9fq88miGEJNdQrVo8I7h1Bu6gxE41rDJWnBcgOK3
         HN0A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784453600; x=1785058400; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=th85pFw/R60Y/fI3U9L5PnkcKBvcHC3c0Lw2SKZ9e60=;
        b=DfagIpLybnWVHFimCwLCux+vbo+kE5ekEJOWik43huFMXJ//5BFZRBeJol7M7eJzbc
         mYlFsSJV7uldSufM8bGo/a/cEJDw6PM6uiG9erx0QpRCUOFAkKZgT8wvQOl094B7Elev
         5RgmZbMD23/F88ZIqV/dKkWwo4MGMk1KkUJWbruE8G0YVBkmcMQRwlrKXBOA/RChuPiU
         h4+VjFAOf2srCq7fZdm3FRnyAaSFFdYp9ExChCVSTG0EUWOKixTkzJERAtMBAXtqfvpA
         WKwg5QDWlF9iwYeCeicS/gyoiqajWoJoLkHmsT15iMAsvnSTMGfrbr2wKmrKk3x7LS2S
         QCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784453600; x=1785058400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=th85pFw/R60Y/fI3U9L5PnkcKBvcHC3c0Lw2SKZ9e60=;
        b=oOHEDad0cMRJlMn213P7sKAjeOEtElYT3v2k4qQVvyViLXQWufPpTAU0mTAIiECZGP
         Gr2z/kxViya+eyR3cWMOeVIwY/qV8HQL5I+wRBxPVNCPLR2ojuEKMy1pCw3t0QPgD7MX
         g9kIQrCNudEwl0J0GGPFlO7cP+5xOrQtuA/7F46LJRAexncVr/Vl68Ib/taBUnc+cdF6
         5gJfTxegdz4YfDc3amlAQfNJm6vUbz/hyv8Lfruu5EUe3ErJ+ek1FOu0L++vew5BdnxB
         YrqgrgxiPsR4YyCjpj2KJnkGhd6ZEnPLLgcDp6X1BcarL2dMzumERzzl71FK+S4UWHnK
         ikOA==
X-Forwarded-Encrypted: i=1; AHgh+RqKUwUwjMnjREu+oU6k5AkVOizdIHdEZ1iMfqTOO4wui/uTZ7d0/NsqkHMloLoYvz5D/ksZwO0kHTWtFYOpjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3/0WgPlY+gadihL1Askl4rb3zZxRxHpKMtR6Cb17iumxXd8QK
	x7CguKzV0LQytTxsPHcPm9PwKU/VUGg3HJlQWmNHZKyjUF/ik3qxIeHMI+87t3f1JqtV/x6y42s
	xTqmkvi7j2LT+nFDE4kNKeunWfqY/J4U=
X-Gm-Gg: AfdE7clRIeLLzngtNwjsYWsL9Uzr0tbc5fPxm4U3lNSJH4D9li4QATQ8SCmyAaMKGvY
	bhL8ohmLs3AQYzR7N43e7CF4Pzq/Rk2i6royKqIce3B5nuoiL1WXFYqLjuTwouvGhEK33vn90Ux
	KHQjc9op9S6eXB862zQZGmRhsx3ftjJBZtypJvB+4nTEmENEiynEOx1InLhundetly/PV9/Y84x
	TU5F462jDZ+x/36kGh+KlVuohasNw9pQVsUhweFVy7Vyb9L3f1dWZnSTcs4MuncCughF0br64C4
	YiR8PguuH4jHUl0TropO
X-Received: by 2002:a05:6870:2dcb:b0:440:d7a2:8834 with SMTP id
 586e51a60fabf-4569032fe9cmr5051192fac.26.1784453599970; Sun, 19 Jul 2026
 02:33:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
 <20260717155848.GB3998092@e132581.arm.com> <20260717161201.3jkO5o71@linutronix.de>
In-Reply-To: <20260717161201.3jkO5o71@linutronix.de>
From: MOHAMED AYMAN <mohamedaymanworkspace@gmail.com>
Date: Sun, 19 Jul 2026 12:33:08 +0300
X-Gm-Features: AUfX_mylpAmozMkCk1jKEknfPyc5tv-3DxhfyKkrpK14Lv5_bKcsyCVLfLGMwjY
Message-ID: <CABWZVhpzKpTz9A-nHFEYgAdrDWFzmjMZOPW=Zo=wD6Bv6zgfcA@mail.gmail.com>
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in coresight_cpu_pm_notify()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, 
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>, 
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo, Sebastian,

Thank you both for the deep architectural insights.

Leo, your point about the parent device unbinding and tearing down the
data while the PM notifier holds a raw pointer makes perfect sense.
Trading a "scheduling while atomic" panic for a potential
Use-After-Free is certainly not the goal. I clearly see why the raw
spinlock isn't enough to protect the underlying memory lifetime
against a concurrent driver unbind.

I am closely following your discussion regarding the
`device_link_add()` approach. Once you reach a consensus on the best
lifetime model for the active session, please let me know how you
would like to proceed.

I would be more than happy to help implement the new design and
prepare the necessary patches, or I can gladly step back if you prefer
to handle this broader architectural refactoring yourself, Leo.

Thanks again for your time and guidance on this!

Best regards,
Mohamed Ayman

On Fri, Jul 17, 2026 at 7:12=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-07-17 16:58:48 [+0100], Leo Yan wrote:
> > >  static struct coresight_path *coresight_cpu_get_active_path(enum cs_=
mode mode)
> > >  {
> > >     struct coresight_device *source;
> > > -   bool is_active =3D false;
> > > +   struct coresight_path *path =3D NULL;
> > >
> > > -   source =3D coresight_get_percpu_source_ref(smp_processor_id());
> > > -   if (!source)
> > > -           return NULL;
> > > -
> > > -   if (coresight_get_mode(source) & mode)
> > > -           is_active =3D true;
> > > +   guard(raw_spinlock_irqsave)(&coresight_dev_lock);
> > >
> > > -   coresight_put_percpu_source_ref(source);
> > > +   source =3D per_cpu(csdev_source, smp_processor_id());
> > > +   if (source && (coresight_get_mode(source) & mode))
> > > +           path =3D source->path;
> >
> > I agree the get_device()/put_device() pair in
> > coresight_cpu_get_active_path() is not a good fit for CPU PM notifier,
> > because the put_device() can become the final put while IRQ is disabled=
.
> >
> > However, my understanding is this patch might cause UAF issue that the
> > existing code is intended to prevent.
> >
> > The raw spinlock (coresight_dev_lock) serializes access to the per-CPU
> > csdev_source pointer. It does not guarantee the lifetime of the source
> > or its _parent_ device. coresight_unregister() is not only reached from
> > module unload; it can also be called when a driver is unbind, for
> > example DT overlay removal or device hotplug/unplug.
>
> But doesn't coresight_unregister() block on the coresight_dev_lock here?
>
> > This is why the UAF issue Sashiko mentioned in patch 03 of [1]. A built
> > CoreSight path currently grabs references for the path components, whic=
h
> > keeps module alive, but that is not the same as preventing the parent
> > device/driver from being unbound and tearing down CoreSight device data
> > while an active session still has raw pointers.
> >
> > There are also similar race window before the path is built: for
> > example etm_setup_aux() has to look up source/sink state before
> > coresight_build_path() establishes the path, so it might access
> > released source/sink data if device is unbound.
> >
> > I think a proper fix needs a clearer lifetime model for an active
> > session. E.g., we could consider to call device_link_add() to prevent
> > device unbind / unregister, and unlink device when the session is
> > finished. Once that is in place, the CPU PM notifier can safely use the
> > active path without get_device()/put_device() pair anymore.
>
> Right. I am also not sure about lifetime of coresight_device::path.
>
> > Hope this is clear and makes sense.
> >
> > Thanks,
> > Leo
>
> Sebastian
