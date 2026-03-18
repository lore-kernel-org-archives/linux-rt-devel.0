Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0FC125B2
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Mar 2026 00:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792727; cv=pass; b=Fl5GH5iJSGMOvXR3equHZhkC34Yrfkz5tn2GUnOO8OjGg3+dqtV1NeS4+iEeBr6+qE/YT518Y8zNo+hUIpLe6wkILBr2KOgZB1h8RkXg0ydb1LL0AqceDDLfpqaG9e2zbil2tGRA3UwkKgz/+AakrWeREd+CHYFMgH3wmZeP+x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792727; c=relaxed/simple;
	bh=knEiv//4VD9jJeec8RxNBDwCYflHSFiOuljpRQD29hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe9YttDp7Yn19p10kvgZujhvvzda5I3jmVJRCRpxY4epyO54zXom3Q2LHeyOXPwg3z7Mox3GqwUNPk68mK6ERWPM8h1/IK5Q9YSJoQVGyoSiFNzhKHisRjAOlj2f86TVkDKNgqwv27iS1+hfGNEm+euA6hmyZdfQpqzJxFSreY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/Nizo8p; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/Nizo8p"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad019bbd4so6603081d50.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 17 Mar 2026 17:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773792725; cv=none;
        d=google.com; s=arc-20240605;
        b=QTBsg9ICo8tccGMBH0Z8Q73SaNas34xe7e4qM1aQL+vsNTHBnQDkFD3viVBGemCMG1
         Zkrs0FDmCfvBHqnuWfzF5Fzgc8grf5bnXnNu97XAXHjAwPtgyoPu/T5uoxvGL54H+7ti
         EmJnVlwbjlmzYOcAgIPvdMO0PpbhEz6QeHq2JSACO9Ui25YCdcq9w2EpwK5amolStpAJ
         PxOuJicirP25upZxW7Qm8tSbU9TX+3uJ6ixml4AudYfRf5fLmJgYmMtC9hq03ytoZAxQ
         wDSnbMQsDL0AKGnqn+/6TkI1D5U0+lLs/QSBGzwNh4JCUtbGRlsYGJkjAaQ+kUeXMEvv
         nbqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        fh=87ngM57PCscjDpMyxvbdYOPnRdYqoqGhj87VZnLZQFM=;
        b=U+fjlU08yLO7ff9FqpT7zCoMqY8WSNA4JuBvFbHTK+ndfrNShIgkcTHmOOI7mGIaQg
         rTJQR/bDl+uWPlG7DGEY5/bUnyCLXfaaEc8DtS0nMW0JI+dKNzB/EYk50J6SchAwpEh4
         eMRp1nFaVTkjbQQdDptH8t/qYodsuS1td7R2kbp0i2F3WQVJK294DHsPXKIqB2NUh23G
         o3FO2QdxXmO5lQCGNA/hNTQc7twrwAypZzpjwgxgx7um2LVln6OT542Ov9JyUDR61a9l
         DSLpmjbFGqKiGBdhpyjxcj8pPtccxpXBCfHe6mlfEhPknklRg2tuZ/aq9k/XiEZRLgmN
         pkfg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773792725; x=1774397525; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        b=L/Nizo8psSCf1hmfAkie3zbgD9tRbyBv/PBVkCzPHGi52uuvHDSr3tgp7kccfzNpfI
         rlE7/52atvWw/c+T14khD3lyQ4uit/FyG5h1RGZ6Zq8Bzc/MkVptY5MicRpkkwRhBf+A
         ZIYLmolqwWiCAjbrktRrJfOCDj/RT1VVqc6tj5TCMI7fqQBbhfYoZcqnXGG+ak8oqEvl
         8LmO5qZSIWg0NQZzaNCnZ569/m6JuX6orASRyDZkk6O+kYl5qBhQEV/2irRPiMQkhgQi
         e/10HEL5ejFawK3mB2h16LB07jWbZFsV2oZmsr4+gOeKht96ioV1yc1xiTdXqMLmPtUI
         ZnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773792725; x=1774397525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQHa29a0F9hQB3K+TT1RUsgpE1a93bcbnQ1K/3gSFjQ=;
        b=pLrbiw+RhTRs4ufDOWiS+g3a4uNhFggPKZ2NdspzLEBUpnOz6C6WcAwWVjZVIiPbXi
         lrtxbAoJlYblW4i6800hyUZFu3vLZueuQu5kuRgAVWqYA3+V1BonW7b2GtDqqgACt4vg
         YHOJ1zbT+/wHNv8ZGiIeUkyy/HBJGn3otac4Ez4mQqulFgxujgx53Pzb0ivbVst+aDTX
         5NR+NsPl12MR9Vx95MiNEFOR74d59wghP8ts0KVBCAbgSJnPFvsFWm83PG2C7JeJFXrr
         2uD9PvlTVJ9NvN2csDipbrkQNgYbWPyRr3BFD3B98t+JnoJlinFGOeY1tEYPeGwzI+nG
         v5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCX2q4/Ui8HszMJz9LDHvkaIxlaOoAaglxyb5YWPG4dI9NpiWoICeDqTePGfIFVAm2CUnYWLeb2P/Yhe0oBBAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZw9MKSy6XU1rpyxWwC+cQmgXhz1BxkuEEQ5mvTixGePNKV5uE
	CnGAMpqJMq/92iv61pu/aN25mL2eCyQ5zUj/XHA0SBfMKd5NC7HyUGGYbXha34PCH989yqlXAak
	6fZNvQ14KiPtELMhshH4rt06QREuRLdK+/8/VxTVZ
X-Gm-Gg: ATEYQzxmMUck665OBiZC2i0lHQGO/hlXZOnYVrq/ImtRdUhh++hTGR+FeHQBJQd3aHI
	MO0bEsZ+7xdNTIBtjRN6hKA0T3GRSrafdyS43NulzhVP2eSobNYipyKRyK+mNaLROW/LuSGMq+i
	endZXaTUi3sIW3V1fJQq1eSvEG9BDwgppb+wWw8SYS6DlNmZgYT6/cm7A/SjiszlhWUI1tNFV0H
	uJqHwGGNOHfrA++ULT15nUggiLhRz8ijWe988rem9Tsg8UtVfwurv95lhpZM80Cx27aXZvPePeW
	A1+NPI8bV45TXAHKQoYTlRZdcNo9l+cloMM=
X-Received: by 2002:a53:edc1:0:b0:64c:a4ab:e4e8 with SMTP id
 956f58d0204a3-64e91327c01mr1498946d50.20.1773792724985; Tue, 17 Mar 2026
 17:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260316232819.6872-1-emil.s.tantilov@intel.com> <20260316232819.6872-3-emil.s.tantilov@intel.com>
In-Reply-To: <20260316232819.6872-3-emil.s.tantilov@intel.com>
From: Li Li <boolli@google.com>
Date: Tue, 17 Mar 2026 17:11:52 -0700
X-Gm-Features: AaiRm51lAT37d5orb_kuGVpaQVhsFcoQau7SuZhTPMn1qsiJkxQa_jxj52FffUI
Message-ID: <CAODvEq7Ty-D6MPeS0r3077jXWMX0i9yp3UB7d+mnGTaQGegH-g@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/3] idpf: set the payload size before calling the
 async handler
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org, 
	linux-rt-devel@lists.linux.dev, sgzhang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 4:28=E2=80=AFPM Emil Tantilov <emil.s.tantilov@inte=
l.com> wrote:
>
> Set the payload size before forwarding the reply to the async handler.
> Without this, xn->reply_sz will be 0 and idpf_mac_filter_async_handler()
> will never get past the size check.
>
> Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 21a6c9d22085..6b9692b30040 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -627,6 +627,10 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapte=
r,
>                 err =3D -ENXIO;
>                 goto out_unlock;
>         case IDPF_VC_XN_ASYNC:

Optional comment: could we only set the size if ctlq_msg->data_len >
0, in case the hw returns some invalid values?

> +               /* Set reply_sz from the actual payload so that async_han=
dler
> +                * can evaluate the response.
> +                */
> +               xn->reply_sz =3D ctlq_msg->data_len;
>                 err =3D idpf_vc_xn_forward_async(adapter, xn, ctlq_msg);
>                 idpf_vc_xn_unlock(xn);
>                 idpf_vc_xn_push_free(adapter->vcxn_mngr, xn);
> --
> 2.37.3
>

Reviewed-by: Li Li <boolli@google.com>
