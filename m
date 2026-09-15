Received: from mail-ej2-f27.google.com (mail-ej2-f27.google.com [74.125.228.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D7C3D88F6
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 22:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511079; cv=pass; b=MtuYl3Brk3peYH52HUaHgZRUCKr/ShFd3Wvo+o6xU7aToyBHVwodS3pRCmt/9Cln3LM9t3WBdGgp50FO3v9noj3/FvZBKJU6EWhciCY/JONQaT3SlCWpau3tdkTaR0b7Zb6ElBrfCSlZ8Cc3YAZ1QOZOwRONcW3f16jzdphCYRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511079; c=relaxed/simple;
	bh=glk4hLZeB8BNV8FJN1ZJEgfUHPNFsCJRMeqWRnKIk5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXTHQk60jgDnEC0BIhUXRDlPNfASpAX6TSuI6qIuMMnrCnY7K3g+vRoLr9m9rpLuaUCUYXV4WYDpMgNJdCK5utvnqT/8k9MZvw1qQJ8Yo0j70QRcB4F0l+Ojj690QIqMW5sB3yjzqat9y8ouXTRdpBX5gZ0MgjtRq3V7HjYHAZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjTGjxpj; arc=pass smtp.client-ip=74.125.228.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjTGjxpj"
Received: by mail-ej2-f27.google.com with SMTP id a640c23a62f3a-c254f6c7a58so55618666b.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 15:24:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789511076; cv=none;
        d=google.com; s=arc-20260327;
        b=iYDtGzevWhulINwrpW0e169RuuyP3PBCkH42/ZZtQnhpYRZnQBzW8Wp66zjujiHa3u
         j/2MkXTAce5LB+la3GdCebdBa2yCrgrCup25LymiT9ZCChnE8jXdMDbJ1U33CWbENi+d
         vXZNvOheH85AmWkgRRQ7y0Gp5Vhq0NyJYBG7CBvb/3zw9mglS/G6YcsisjcJx0/u2lFN
         ZmcxUn5tTolQhrWN/G8YzHLRtlTF+DxqvbZ0qpfSTHxY/k8wmE5/6knmWwonl6myl6cR
         Se9jI3j9dhMXkSzs55ceXcoPkDfcBfOeVCPJnP14GW3MWCA26by//nxUrXWSBgxcP3x6
         eU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLnNBMG5QZIWbGY+kDvGdV9CDFonw3WRgIqwznl2sBU=;
        fh=WstP/Jq5qNdviQoVKLCGszvWKfTUCnKE8Fw3rZmOe6k=;
        b=nqMrXxTt4RlKf+bRfivnDFVUqGCA7LHjkltUEcMuioVBArCaE3rY/Yt2PHg/DFVqLk
         aBEQcvZHXF0SI2lqWmTp3v9MRzg0v6g78d+txwAFa1ayz6iVVygjxNNoSHlmOkGgzzOM
         CZTXjtVMG32sHHggBIe6XnXvsalexNQhA8mOAbKLXXuiX++aST0lmVsB8WgLEax4w3Tt
         8R0RSCrHUzp342KNSmUMFhdQFxuBxcBYBOn2MlhzNmtehYmOm5IVUjYzmrl436mgveab
         MJaoB1VNIMF/7z1VUbkXCokqcmmssubeqjLjQWWD2KmvEBhN7yPelNNGUygA0yPt0G6C
         ghmw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511076; x=1790115876; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fLnNBMG5QZIWbGY+kDvGdV9CDFonw3WRgIqwznl2sBU=;
        b=fjTGjxpjFn/nLhO6OGUXcMLAhaqGvx9IcZFasrzM7XDn1lBoH9WWz4qDTJoras68nr
         j6MvF1b/hxfjjIj47O9hsBanwLrFv2HQ8Z+OFSy9ompiyD98NaIEQK7wrGoTlolbMp/O
         YF280z9SSYYKkqRh6BDFVElomd7edUSOcvKR9JFs/3oEVAk8DjB95QBOMDmkYXxD3yKC
         fAAoC/xYzrZ2GS1KDFAGY5gylWeGK5sAkm/zanVEGczijHkSOzxP/dx1Alb42iGPwYlK
         t73QvfX3O52k+9nyQ3ald9BAFEn4MSvuXu5E9MSsrZ5rfR1vvV4hUqrdQSaE9ZE3rX7p
         enqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511076; x=1790115876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLnNBMG5QZIWbGY+kDvGdV9CDFonw3WRgIqwznl2sBU=;
        b=oYQHBxmTpyQYJ3COHW3KINt8h+BFtnwkOPdgqirR2UYK7O8KjUE8IlGPWDOGWb7rxR
         RRXfrZmNxJu56bP3A2g+NiftjdTljOOD+qE3THqELRYRWBoG6EOwa/sceCWgUkZplajC
         H2z+lJ5kFCFwimRbAuxy3RVacesGSsXRhCqJNGsxJHOPLuXJ/WEBygjza6eRO+5oX4Sg
         E1L4j8GDSV8YlszHg++djTeGvrr7kEIfvs06Fu+pkRvfMpl0a5VUMWOQlL1kRqIGQ579
         NoNHmHtbVnHReUwpabmZgyCkFLRZ2xxW2A1i4ix+L+7j6JjaEfSA3nkO+exoaycNahvA
         frlA==
X-Forwarded-Encrypted: i=1; AKwUvBypyN+j+LbqmAzUr1RvusN0mB1LiZdymH3rIyWZKThIgFqW0q1SLfqokehizhPn47y7INMyLfke4GQrhGbZSA==@lists.linux.dev
X-Gm-Message-State: AFuF++nGYM7pp7iWegpeCRahz6JJjHnmSO9Zlf+iSvpO/eVrqWUSyW/a
	qXlVgxOTW0ZKRUy4eScfb7A/RSViyRFLy7MHrJ6vYEDxg2KLHfPOUVteObooFWNUHLLjpNdoB9/
	P4balQ9QkR3SNh9ycHp1TIqsEfpPdXtY=
X-Gm-Gg: AYBFou11sLFCr0OXKDvotGn0SNLAjGJlavAg+mkIX1sCsND/+4vgEY94rxUexosQ+wA
	CRp+eLseeFSp4P2zaGQZ0KmOzYAFcAEAKQM5N9IwJDN9tussfO2N8JuL9zwKLPhqDq6kMW8mAQ4
	LNJryMTbnUAInx1INI0pQCq44InOS4goV/GSYC7h8T0BTDxByj1JvGvrz2ag8e39+PWcl2y0uap
	Rhx6QfGOIhWempPdDEQDTXk4D2fLAzgPQRozIM+z1uM3pLj/MGQVBYWb4V3GwBEj74pjz9xuspr
	CNxorB9RDuK+mBiimDdX7XsOwcqFU/xOTqdNsxmGbinWQO4yP24nj6lCzgJH246UYsNGVH+b/jp
	f2+Uqt7oNCw5ZSFd1BqL73Z0qgTeeQUupZx34zZSXi8/mk4zE1OSxs2QTsMMJOvLP7wQr5Fi1mK
	KmhewC6LhHf6Eu3uKWuhzbJoT0Ib2q/AKJGXXuNnK8sD01qQYLek8Wm4TJIznkx4/e8hcFeXq/2
	LJQ
X-Received: by 2002:a17:907:d26:b0:c29:c356:6984 with SMTP id
 a640c23a62f3a-c29e51dbfdamr6340166b.8.1789511076181; Tue, 15 Sep 2026
 15:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260915004406.115230-1-rosenp@gmail.com> <20260915064352.T4HiPnt_@linutronix.de>
In-Reply-To: <20260915064352.T4HiPnt_@linutronix.de>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 15 Sep 2026 15:24:24 -0700
X-Gm-Features: AcwNN1UmrBuelDzySu3Or0uOP888_AzAr6sVGxMbhPLw-5AZIgjqW0vcNetLvrU
Message-ID: <CAKxU2N_+H50zy7V0FR-_4KiyAG8+_x4kg2QZBsumHEXgdwmqKQ@mail.gmail.com>
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:43=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-09-14 17:44:06 [-0700], Rosen Penev wrote:
> > mvebu_gpio_resume() writes the edge/level mask registers saved at
> > suspend time straight back to hardware, bypassing the irqchip's
> > mask_cache_priv.  genirq skips mask_irq() for a line it already
> > considers masked, so restoring a bit in hardware that genirq thinks
> > is still masked leaves that line unmasked behind genirq's back.  An
> > asserted level line then has nobody to ack it, and the moment
> > interrupts are re-enabled the chained handler storms, hanging resume.
>
> Why is the mask value changed after suspend?
In order to keep genirq and the hardware in sync.
>
> Sebastian
