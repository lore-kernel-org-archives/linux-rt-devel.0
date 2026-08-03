Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D430D3F8
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Aug 2026 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768780; cv=pass; b=AKNybZGHr8TVOZSo6wqUFQUR/4UYHjDply5W2Q09nq9lXYOfB0K7gYw/FhDhtXvtH7ycL/ySEGUTvT0iMwp/dogCVJIqxvJpe7ugb+0i4cK2vmRAZNRsLIfXayiZfVq6OtiMeN1iuN1md27ZmmOWhXgGNI+GcQnoZWJC4W2kF8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768780; c=relaxed/simple;
	bh=/s1sQ2l3V+Zh5c4gyB78SFEqAxnr/utg14r4UNS3vFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbknhzmpcytcRlNzMLGuw4tt2OcAJP7/8jE75BQOwbjI+yjTCElR0lVCdDQePHxVn0SqIKBVd3+WHAqW9W6ZezRC3lix46hECDPjeCqW1DHUamACfFYxKFqce9wQjktIlpetY4+CKxw6mAfJYJFC9rJk3az/GOpVuAc6szIVyDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBZ2J825; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBZ2J825"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c15c42a45adso623177766b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Aug 2026 07:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785768777; cv=none;
        d=google.com; s=arc-20260327;
        b=dQ30JAwjOQ0BQTlZMzdA2qXrqy6M3MjTks70KY+30VDUp0lHPMoKjmye01haqpNv+H
         /EUaNsLpmc/Tbmum0rsq+1jikg1c1oCrIgNihBAxC7ZaAJWW1VeqF4xkOlz+g3jP0Fcf
         UCUaE4H0bujao66KYCpuZzpKb7vH2zs3Mn/Ay2TsyY7T9MoQ2+5bIvvlZjPlQ0GCSRHy
         v5Xkeoa0XW2wzfxTrOAgXRO/0lksf/pkxzn1dzdd16hvVlDu57D7XKatK4CHxnxTJohp
         YfQlGdiR9L9vPTTNf6Ih/gE0G+/tuHDxEhQZa4X1BMhfVAo8Hgxs0zlT0EwCP5yGnDub
         kaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        fh=6nCGpUrCQpI8wHTxGXFoR9KWqOJ6UYN2ppoznGASohc=;
        b=NqSsPlI2VH3XQ3QxLzeNz2Yx+qIBY+1WGWIFcl0+B2wu1OlBqjgzAw7eMdKeQSY5Ij
         i7Rs/uojDoSPVjes4PwXt1UHnLdko3bVYd+qnSaFaB8GDWX69BKkQF/BIRsxJqVMWwlK
         8D722shZSz8EaxyZSZgDqigjWVE/tXr5bGJkmtdeW/e8/TG722Ys56ONJLIheG/S7tYG
         Tx/0o9hZGE51Gl0oQL1ONjj1CS2wAN9E2G/IeoFcUKlNtwRsC6Z3xrB4seIWihieLexz
         Gta/zuJo5l9bunLzAgYlLESVOz62uO3d+G8Mffqhc/t2rbXJ6iu19Hb/aQ4HM0NS2v9C
         LNig==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785768777; x=1786373577; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        b=DBZ2J825uqR8CSXQ5mv/UVFn0wG8U7YBq3qKqmF4MEycWU6dkpAWU2XNpYObRVvmRO
         zl2oUhXCxFxC52d23ZQnvbs4QnIH81R14+6SBD0pahlJNTpucYptCfJLwEuAyGMs//po
         voYcXcHmVHmb24vISCp1VggSX11A6VWBeLNsl86IBkyek8QP0dJKx3Pg0lBnhTJ9TJOt
         Xkyv2/qpcH/fl5HGG++qyI7nVrs6twQV9kZ7kSdTkpIPrwdw7n0fNr6+NjYzqSSUjm5D
         xVfcGiB3btLxIhKxVWqyKfGHix+3UQemy6/HwfQQ69O3VnanUn8+0kBSB2EaZeL12WTb
         bYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785768777; x=1786373577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gaqZa2jsEJ+PXDdqAGoYYjGFntXfTS4TlPa6oioaHio=;
        b=gh3SHCnKBal8QkoKd0/bWAydaRzbwt54NVhJcmR2kD9J+v7Ca669OlwThSAKvR7W4B
         zkFucckWauoCSf9qkNkLMh3blyACfKPoy7iYiG38PX/TL24U/Vq6hQJByypPbwGOYFLn
         NsDSUJwPnaSheEVwI7m15cUI4MqjAbnlbJM16fksq4Aps2EfbEYDcWshYWuDv/Hh+OWc
         4vP33f0FFi8idmHgT0DxSvlYyyNl3035K1SvlfEIyjHS0r13jJNPoZWVnlzuJHUBtMhq
         KRgmbY0h7yxyfepjEBY3BUuvRBnSmCvbE1kVftDpE4fjvfpvPY0xEKWUnq96UvGPU0Dc
         O1oA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+hncZhdDZQJne+m5IooG8NzeImdRsTDo5kYBU6Ki9rFPfwNOLq05AIZC4hOMJvb9x+joI/1+WqPbfKH9ZGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw0iDsQIcicNAJamcO+dVcEKwijgZODaMxowK9OsS66CcifApzo
	rJTrcw7dujsQ2l36EhduWHdRHaE87JTkQPbcP6PGDaloIzfir5U686FLaMqHMFeKk2RuyNDhRpI
	Va5NvgFt6X9kHU6QaT/xBV57Y9jUifsW0HRfk
X-Gm-Gg: AR+sD12428z0fTHxC2OMOyiGJUp3xM6Vk6WH+YyEIOaJQzPRGLoYULOIJxPjEprgnrQ
	hoXO7+PecBpuREKLsIA6P2ML78kS7Y8jsZvdEhSwjOmW2b5EoHErt9VHh2+t0UqncvBfzX/xH42
	KJcubSzSl9v/1+zxGveu60bP/4r4xv419fmhyL/PbOWskMvsNC53/f0YPIRsvUL8GE/XSgmT46d
	Wfpmw92QFeyb52FQuMuZbLlLdINQTFsOaRGO06TU/Yd8m00YGXHDfmlGx6WFOb819J57WmraSY0
	i14+vt583L1mXlBrMzAT/AIZ8uatPp8W2bM11nKdujJymgWEIivDFtzCGIk6oI8GJTsiV9E=
X-Received: by 2002:a17:907:1c18:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c1fe79cb8d4mr727328766b.11.1785768776864; Mon, 03 Aug 2026
 07:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260803134839.2103051-1-puranjay@kernel.org> <20260803135329.2327280-3-puranjay@kernel.org>
 <20260803144919.2D8C31F000E9@smtp.kernel.org>
In-Reply-To: <20260803144919.2D8C31F000E9@smtp.kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 3 Aug 2026 15:52:42 +0100
X-Gm-Features: AUfX_mwMzyeDA_Llb19LD0lSRMTtOT-ohduGZiy-4600iqiO6ncPTdl5EcnNmtQ
Message-ID: <CANk7y0j12i-Ck9h=Lh-tVD2wv=rp-OKydnkX=tz0436Sgr2GdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from any context
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 3:49=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Tiny SRCU's call_srcu() remains unsafe to call from NMI context,=
 leaving it vulnerable to list corruption.
> --
>
> --- Patch [3]: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from an=
y context ---
> commit e3be0303432c7c7afdd4ed014dae0987e25bf7d3
> Author: Puranjay Mohan <puranjay@kernel.org>
>
> srcu: Make call_srcu() safe to call from any context
>
> This commit updates Tree SRCU to make call_srcu() safe to call from any
> context, including NMIs. It defers callbacks via a per-CPU irq_work when
> interrupts are already disabled to prevent list corruption and deadlocks.
>
> > srcu: Make call_srcu() safe to call from any context
> >
> > call_srcu() has the same constraint as call_rcu(): its callback list an=
d
> > locks are only touched with interrupts disabled.  srcu_gp_start_if_need=
ed()
> > enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree,=
 as
> > do callback invocation and grace-period work.  A call_srcu() with
> > interrupts disabled can race a list operation in flight on this CPU and
> > corrupt the list or deadlock.  call_rcu_tasks_trace() is call_srcu() un=
der
> > the hood, so a sleepable BPF program freeing an object can reach this.
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does Tiny SRCU also need a
> similar fix to safely handle NMI contexts?
>
> In kernel/rcu/srcutiny.c, call_srcu() relies solely on local_irq_save(),
> which does not mask NMIs:
>
>         local_irq_save(flags);
>         *ssp->srcu_cb_tail =3D rhp;
>         ssp->srcu_cb_tail =3D &rhp->next;
>         local_irq_restore(flags);
>
> If an NMI interrupts call_srcu() exactly between assigning the tail and
> updating the tail pointer, and the NMI handler invokes call_srcu()
> (e.g., via call_rcu_tasks_trace()) on the same srcu_struct, could this
> overwrite the tail pointer and permanently detach the list?

See next patch it fixed tiny srcu.
