Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169344;
	b=3XR/YT4FR8Gs1LBLQLkqUcArcCzDIAMpoTAln3kYkwIDRrYRFWQuFI3RFP5jyQEBnc6L
	 B3lwdo8tJzEl/+J0q2h81Ok1mEVAQV12PKYIIzbqTNSc5D6ySvO9C1Rfjy5i0Ex+JzxFb
	 7RokzcmbNCX8ek9sIPmYwM0pdLRM1nC0s4lhQuSXmkM16AVGxJczK2mcktB5LFgmjRhGY
	 iA522UyC7xkIifWjSjjUPM2r9vhsHJSrW8rrDtrmyGTrvLt2wCKGtRS1fTGTZeLboCYKN
	 Q5vNDNeAU95p/NajLKR+XY/kLq6KrGT3kY0Wwdwm6uYOHwvxtmgnFSWg+emm4vfVLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ClT4OkKbeUzu4ym5icWWj8grU8fCfsMlggCJDN6YVpk=;
	b=GAT+3rAiGmSZ5Qs9vW/br4uo/WznYFWC5S3HFOVgWVofwS2FQYjzsvcLD+RpFCRZHcjY
	 LLdNFdOoMF7W9ewTmqavwwaMh9UvoxGYiBVIgnA7oPv1iYWMBgdz3LRXZ8ZIJhYNJQWX7
	 PWBFSDqfVLoHrvpUC0N48jGyTCNEYUPhBwoRuUXupR3ImLGRExDm2GqkxEsa2bgDjAQ6a
	 neUYd1zIjcbDB35RO7/UjGfvRCbbTKsMPF3cutUbzIrziJxIg4QDyb8S5gTRf9yYcawCb
	 Bq7zewSjsp2/JG9nJ96U8xwA9xh6V7HBcOco9WALzDkNBoBn6k8ZMHxkmA0DemlictQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afJdlujg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F060A2637;
	Sun,  8 Nov 2026 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=afJdlujg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A591F008BF;
	Sun,  8 Nov 2026 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169344;
	bh=ClT4OkKbeUzu4ym5icWWj8grU8fCfsMlggCJDN6YVpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=afJdlujgQOI93tQLR9qTAPYX1ULvLFUMk/6HymDt6JF/0Fgy+JX51O9Imwlbn6pTK
	 PegT2nos6QaoHaDi5/VUAaTH1XAlEintVNwZ6RTmd3v4Do63HQS3sJxIGgqAD6rryo
	 fa6M7Nt4Lyf6bMM+D2FlRkIcmkk2jOmOC1rDJsNziAZ98AoWkA4jK2TvkF4tF4hFFr
	 Lf/xZswapNDmco/KEBP36J5eAKTHz7A2qWhj1RVd5pB+WDKoxxkKuTSeCbD3pE8tZk
	 qqUbh6JARZpkHNhcBNzD7cGJVYc6Y9zQvSdmCGzIxkjsMbwadlrk1DBOaZxOF9sZYn
	 QfCuyVSM5WQcA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ilia Lin <ilialin@codeaurora.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: (subset) [PATCH 0/3] soc: qcom: several fixes for SAW handling
Date: Sun,  8 Nov 2026 14:19:34 -0600
Message-ID: <179416929434.628393.10612241359461414562.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
References: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Oct 2026 17:39:18 +0300, Dmitry Baryshkov wrote:
> The Qualcomm MSM8996 / MSM8998 / SDM660 platforms use SPM / SAW core to
> handle lower-power modes and to program core voltage regulators. Apply
> several small fixes to drivers for that core.

Applied, thanks!

[1/3] soc: qcom: spm: fix the SDM660 silver L2 AVS control value
      commit: 2fe8c4fa0ae7787e81d3737854ae4ae2c892bd95
[2/3] soc: qcom: spm: don't clobber the SAW control registers
      commit: 25e50bd0fcfb3a53fd505460d87bf67c21da176e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
