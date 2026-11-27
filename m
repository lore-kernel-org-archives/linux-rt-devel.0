Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791829;
	b=XDVw5n5TBEspLhkxoGwkOO+Sitm1HJGke4QNaOXye03PA/PnLvtC236jIPdolB9Tw5eU
	 UKqI3OotLPafvjThrDB3BszTVeY4RkzdIxvyUJ0B1Sx3KOTFRUQn/QN2jaCgrQrlf5Ngr
	 KPu+a6oKg7VSSL9OSD3FMNyjn5LzyGFk06idEN2uXQVFMmiUqlJqsKqpmE1RhzR5lBtHf
	 UahA14xLJfuyP9PFR0DpZow15F4Z+45ZelfGWRKGI25cKmmra/yj2pd4r8vaP/tlBRLRL
	 /4Z7qN05fjsY6We1nTzEBqwFW+qfPgnGV0RZ7AxELWvaDYp5MaJqHQJ4vl3TnMiGJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=igR2PdoSE5zC+luyFOEYbUW1HNx+27WRDKANfZMFdJU=;
	b=vuJAlNbrxLnWzIkYPHNuJjp9+MWS9Jmxw3SoeA9yo9gvaHjav1byzionv4uf5JjtySE6
	 J2jdeA1YSJSwZeNhHNiqigfN7T3kZ3tLs2kaSPnRYEz1Yve7iFL2bFbs7AtS4ky3/iWSc
	 vmoj7Uos1s7TYQpIU5ZRkyQPB41CJoHCbRAXnenTJCy9vuws+syBFBc6wuwtH5C9ClV9b
	 +csciOoIPPPL83Qz9kYBaB0qnd2+9e20bOSEpF93MgKbuTSwUTRcFXofgHe8yZC7fHhRs
	 4BYzJAB7+5Juh1ZPQGdxYHdoI72Ya2wy2CYHHiETke/ujtOMogZnQZ0yfSZPortKRcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wYfF6e09;
	arc=none smtp.remote-ip=74.125.227.132
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBE606A31C
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 15:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DBE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wYfF6e09
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-3b497279c25so2561384a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 27 Nov 2026 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791828; x=1796396628; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=igR2PdoSE5zC+luyFOEYbUW1HNx+27WRDKANfZMFdJU=;
        b=wYfF6e09rNftXrlJQDyyvjfWZZMTx/boSw5tpHxuV4n8bG7SO5kt6pT08AlosLj7fv
         z+44e9pYafUv8ql0t53IK7uYlwfKwJ43nAF+mwg4/wWLf1fkER7nq/fjqe+9Saq+kHwO
         SnS+Iy4/DffQ35z9SqR3ppSJjPxjR19WdCs4AFuqO9JVNezHY+CGcd1p22J3GVvbNKX6
         mrwotcP89zLZQ0k6Y2wagZ4Is79R/PW2Wlqpj8WMceAJCm3BtLbUmXZd724oHftp8ouw
         DB+uJPWlnDz14jmGMD/WQ+pKFo5qNRbFXcbEt+BLwOwbgkpw5FeHG3Vk+M2scdntPQIc
         i+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791828; x=1796396628;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igR2PdoSE5zC+luyFOEYbUW1HNx+27WRDKANfZMFdJU=;
        b=a0enGNkZ7k19aPbsTGzsiV5YMdINiyoXHwsO46ZQoka8U6AeTZ/Kb+exHyOHCs3P1i
         2OOgta3mMGGqlzTWtMSYYP6/ebJMCqwMJ5HOF7HaUV+EtzyW4exWB7Onah605oohtqmg
         W8CDoEFZUiJJk9785femRxYtzczzbjpxlXzAvT4b0uRaIBDYK5ZMcyhaqL9vsvJ1dS2X
         yW19gwQ2gggT5a6mCkYDJj73Dl5vv8fcFsVDyPYt3b9nd6CBZhNzUH+4EDjvqyzV2cyt
         dn3n0eHrY0isGcovSVPX+BrVDdwGtYs3kjdPO0fH0SN0yF0or9HuM52D+zFhG91f8s+x
         N7QQ==
X-Forwarded-Encrypted: i=1; AL+hErEx2hbGFOroWxlTiv7o1LSe4hCBYPgaR7yQxu4AHoA9N8ujGkl78yf7oIY7q2AaScQS2zgecjKswbq0MRENTA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ZsPf2kuAQIKaNvAG05uFi+qpdV/PKFgZEgZ4qXgupljBeCKvs
	QkVrnSBHEkqWB3ymUvKNBH36HyymneFE31R6J5CHnzVlRX3ol6ZyQSgp
X-Gm-Gg: AZFdTZeTStsOWW8Kxwlkpkq7ub7r0pDCyJXSgMEoyI2jcpHwSsckMlnhRGoCJvztsP6
	Oh3TeoTengt9Vd5Z3vw7y7Fzrpaq76CKEtL9ls91995vQDJNA//i5jZ12ZVx77Nxguo9gY9UjHK
	yCqmrEhyKaWLMvq3S1WNgYeDVAGr+xvPMtV65wbz4Si+VyE8AgCeYkRNM6g61fUpN2cw7lLlh1b
	F4Gkhgfm3WzJD+cCkpyvBJe+IsnmPh17+xErTlJwfsMhDyl7cJLS0jF519swiFsxgyGKyMqybY/
	SmsdnbbWwbW0WlbFmAgK9e2G3W1D6GYttmbHZGs45DAMws//R6Lx63scOPI5sGcvRImX4ClzBgo
	w9C9GVleVN1RWMXmhXBfj6TXKANr+g9dMKR6GAUp20joOjVcQL6taH/HYo75rkoLz6KalHNGzf3
	uX6wG28gg0LxDUbK3sYLJuKFFLTPZxb1Z4U0VVUSSAX9fGoQI0scJfYSypL2/j6ftaVokCL8IbV
	r8V7O8kwGaZE/iYSJ6GB2gGZpnaKHeE1+CtdakTYtfFri3799denGG55XGWvGsgf00n6lTGotmn
	5hrTCDTXkQJbqDv81/u6j9umF9I=
X-Received: by 2002:a17:90b:2701:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3b41c8d9224mr23715014a91.10.1795791827753;
        Fri, 27 Nov 2026 07:03:47 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:36ba:d0f9:ff68:162c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b5210be133sm7345191a91.11.2026.11.27.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:03:47 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: bigeasy@linutronix.de
Cc: frederic@kernel.org,
	darwi@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Zixin Wang <w1355457260@gmail.com>
Subject: Re: [PATCH v7] Documentation: real-time: Add runtime tuning guide
Date: Fri, 27 Nov 2026 15:03:30 +0000
Message-ID: <20261127150330.798248-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126114102.615558-1-w1355457260@gmail.com>
References: <20261126114102.615558-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

I am sorry for carrying your Reviewed-by into v7 without checking with
you first.  I should have followed what the process documentation says
in Documentation/process/submitting-patches.rst, section "Using
Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:":

> Both Tested-by and Reviewed-by tags, once received on mailing list from
> tester or reviewer, should be added by author to the applicable patches
> when sending next versions.  However if the patch has changed
> substantially in following version, these tags might not be applicable
> anymore and thus should be removed.  Usually removal of someone's
> Acked-by, Tested-by or Reviewed-by tags should be mentioned in the patch
> changelog with an explanation (after the '---' separator).

Since v7 changes the CPU isolation handling and the rcu_nocb_poll text
after that review, I should have dropped the tag or asked you first.  I
was wrong to carry it over without checking, and I am sorry for the
oversight and for the extra noise.

Please treat v7 as needing your confirmation.  If you prefer, I will
send a v8 with the tag dropped; otherwise I will keep it only if you
are happy with v7 as-is.

Thanks,
Zixin
