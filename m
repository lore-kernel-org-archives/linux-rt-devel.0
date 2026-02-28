Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6026A088
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289318; cv=pass; b=hIS2HLUDj9Seq9/TAvMj+Y9+Ho5nGbpOgfoZz9UpQmk02W6FhF98kDjlGTsWowjRW/2IgobYRIo4tVR3sUV4L22AdDPYAYp+N4aJVUYyGPYFeo+3X4snZobRjH2GMA1oMLZX3X3UpmAxfdj9TCw43wHUqpqb0kdNFJB56IkJIh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289318; c=relaxed/simple;
	bh=1m01vviT4f7E960ICQ27OqQpd7MEnNDFVcc4J7/VRIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeLGR+j8H11U/bKM2TbGXu9hCpBbXrt9/YW+rET+d/QPi/Uvjlg1lgn0VtqqOq6BEwzzvt69QPBnNqTG2blMUzGINg03+bFQ1bJcRg2+v9BXWvjf3Z2fClBlwZp+qYpoPihwg5Gc9EvUII/WJlHotcq4ND1uLES8gzHwckqpb5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVda+5Sq; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVda+5Sq"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a3400f30so27076301cf.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Feb 2026 06:35:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289316; cv=none;
        d=google.com; s=arc-20240605;
        b=WCb7xZ352F99dKRjrTI0EcxRk8fqog4GRfwilL36R81iQm22JG6B5hZ1T2uQdOmR9+
         1WDakGwDKC8rfLyAue/7hzXEtuVY/3s1Lg2fnDmfmuAfhIDYIe8OLH1JkMm+3T6sURuJ
         +GYLCIAGdWQBi3ShiLA8eYCfWHLm5TOrnrPRhyoiazHCZrVdzYpClJnMIJ1DovX6ne+I
         0ESbuMYBbedc8STVpiLwS0dQbOfLs9Y8NpfPp3pAs3fxbsk28P5dROZoUtFNb1WnJIeH
         dRlFgnCub49NwJM3zuWQllqQzx4SdSJmxU0G3eAhXTGxCYCRAnrGWHAABZb6xLQczRq1
         vwQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        fh=tIOZUIgS7R+HQcxLAaSyVvRJnAgDz44bz2tlQSJ4En4=;
        b=R5heRN23wIXX7n+TzZXO16r8k93D6vDFL0CNCut7LftnTq1jB6Rsa7S5UvSzjS9Ylj
         vKTg0PdSvj3aW5ieNyW5l5poRo4F30jL9NJfXcZBNBGhp5UVLdqck8X4QPVvfY5ysKDg
         a9G54MdTsBgBVAJKHFhxgxp2HOKNwxAYR514WuOgyl5S7OQmeSkBe8Akr3iUElQQiBzn
         O96gS4/SZiLBu5SNG6FS7+LjJqls16FbN10Tp+LQsS9utrop0DMVNnCKStSXRVoH5NzF
         T0dvujekYWqA7emWtRiXS5tJ25wAQjLC1hh7C0CCtFrW3fTiwwBDXv9T0yThRZoMgX3+
         9RGA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289316; x=1772894116; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        b=fVda+5SqpPd8xLSFxWOTo6do80jT1R2G8f1qVZhOszNc8Cz7CWxdl2UdMXAr4OACpy
         0vUjKUjGSanYN6igcP67JZh6nvSo8e9QVgfOgZBzJHKeqwtNc1AyyfDmz0rhNy6J9LFG
         jwRWltj4kSrDEKu20Ru9JY8bY1oi0RuCzVHrcixmRIlMgLtaVjYEje/jfygB6Ayhbzrc
         oo+Uc0YD5LNShIOs8nNoCKlLOGWq42HH6LFuYuO1QAZ1L7WCwUagroZIT8xbtPvRuIMf
         AshFXp/kcgxsg+sB5lHqVsnptl7sVJ3ccpiK+ftzEmfHnI3+gKwT7CrcASafxrXEHlB3
         ijKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289316; x=1772894116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/hLOrLZhXuQdMDotqQ9Bvl5etQKdPXHisGPLX6sFNLE=;
        b=rhiw7I3TINfCsTaihsZ46QsbpYzcDydgIg8dbgfxTU4hXxNY6JY3HKCEcYLV4IoRud
         /swu0yE5+BNhYECCvyuTgmkMgu+I03eWfHLRyAqYfufzFk9O6+zDm23510Iy5mmkkG0d
         qN2bDulO8q5FMVb+GhkyoeMUCdSmcFMlV0j3z0AR6AT/pIjKyXcTo00nNyfClyevN0ec
         WauotQmf7JPw+z6N6sQoXntzDHuiSuhHIl0nqGvHqRA8NvX10RfwiHP5XRFG/DR3qGY8
         /P07PF1WNsUlsY7xvrcaSSUyZcINQbCdKbV08bCoN92O1rnkdhaFIWLnK3HbnJJSfO9/
         MLdg==
X-Forwarded-Encrypted: i=1; AJvYcCXQfNYlH9/VLpweeQ4pI2qR1rvN8j6z/blABIWVsDcLughh+y09IlSvymzQukO2K5M581cJlssfHwBju+ZzhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU/J0O5NNaaiDximXm3yt6+A0Pc1UIzR3+fbBVtCXxJtNLwJ0D
	RqUefET2TeVMceAcqGPAHCQK5b0DK3mVWsdVk1yQEn9C/PgZnt9fAf85eY3q3kfHkpAM3CGtPfh
	E8F5UBYGKqhBwEpI4fB8SBe0ci9MfURmEROxsV3Tn
X-Gm-Gg: ATEYQzzrCgpw1RvSBmX8KZ8VdNK4Nn6mQpykEK3+HrWuJcubY/EQmwQPMy7JqL5yfxe
	avgIQNnNZPbdUMm7qWdTlrXPgHuu6R5JdVsTqcXmp9wu5z/JEWjB4OP4EivZrGTyZcrmq6ClwCe
	6v0t/wJ0sUMk8znxSGaDYiMuQv/O3wCo27Gdi0IpgHxtJAmI6oQvS/NUA1LtM3SejGHZBOAYTLm
	NeKJ6ZNE0UBpIFsNN94CCxiFesNgy59k+YbB33NVc4zXG9ScOCZcpn9L8fmC1GSEI2S208nKizb
	iuBLcY+P
X-Received: by 2002:a05:622a:210:b0:501:51d4:df30 with SMTP id
 d75a77b69052e-5074433fc43mr139875071cf.8.1772289315270; Sat, 28 Feb 2026
 06:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260228111319.79506-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228111319.79506-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:35:04 +0100
X-Gm-Features: AaiRm53nhAMTYhhG5f-7gMegRJvoDTYPWAA_v2lfePsaGiIy-lArxvtTUIJh4ms
Message-ID: <CANn89iJ6cH9T6UZ=dGYxqHx9sLxX4mrD9U1yUm_DNrvyxYmSiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: fix sock compilation error under CONFIG_PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 12:13=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> When CONFIG_PREEMPT_RT is enabled, __SPIN_LOCK_UNLOCKED() expands to a
> brace-enclosed initializer rather than a compound literal, which cannot
> be used in assignment expressions. This causes a build failure:
>
>   net/core/sock.c:3787:29: error: expected expression before '{' token
>    3787 |                 tmp.slock =3D __SPIN_LOCK_UNLOCKED(tmp.slock);
>
> Use declaration-with-initializer instead of assignment, consistent with
> how __SPIN_LOCK_UNLOCKED() is used elsewhere in the kernel (e.g.
> DEFINE_SPINLOCK).
>
> Fixes: 5151ec54f586 ("net: use try_cmpxchg() in lock_sock_nested()")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
