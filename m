Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0AE3ED5A1
	for <linux-rt-devel@lists.linux.dev>; Mon, 27 Jul 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146828; cv=none; b=krkcHD8alJiwdpu1xJpuH4uzhIoEvm24sqJNzW9tczulnt75g/eQSEG5dxBxh1zckpQdSZXFv8zSbUARFfDHUJGuBcHozcS24vk5WHHzdtq3pKcN/F+9lQqlK/iOZy+rMoOlQEEYR52qxZLGO+DLnsQ9AWhMZrLtGp6alij2Wc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146828; c=relaxed/simple;
	bh=ioBBAAfJQ7MLNN9ECiE+3ISGXQANp22dj/r1mjsy4SY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8gVeUGG7GBtU4Bu606VQpGjeZeGJpWV8RzBwO2SdMnwh2qxwSKIWREshyoo+J51HMZQsJt/hjmKKOhN2OeHHyIceoTND/0MMY4fKMfONsua87Qj0RM82omTVYSnE7RyA0NSonoG5sK9ZL1vCLGuSGYJWn1p3WfnjHOpdmN6Ljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=St+DyE4o; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="St+DyE4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1785146816; x=1785751616; i=spasswolf@web.de;
	bh=JW7ljoZut6yAtM7ShtrcgtUg+78pgT63zTK1Q1tcoDA=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=St+DyE4o4Kr833Ufkboooy8NwJIO0RxS3/uJ4u7WjfTDPjgQ314vO8oza99/W5D4
	 X1keT/xAMAl4+BKrFbB0iGn50cB6cKW4QK1EcOVyf20NQrPL/65kBLKRCtGL5ea2s
	 YY0MJ7lyKAN6Faw2hHZHT7VCpXj80XsABiEogcRrdIl5suAf9Eqkpga9gPhqzKzFI
	 +UJuTy3ipwd1gp5J/dpyPAm8LrKodM/lw2nnEI7j3lcWtXaXl7SCUeN70TJTEdDUT
	 ByqneZOjCZ6DIROJkORxXsMMJC4rwQFysngSxvKL09dcuAgKw3tj7FW8qP93LZUHP
	 aLCav4hQHvVU1cbtjQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUlDJ-1wNeXx0q6T-00U3Pf; Mon, 27
 Jul 2026 12:06:56 +0200
Message-ID: <5b5559e0fcc162bb0a2b7ab9764b8040c981c1d5.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  v7.1+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Mon, 27 Jul 2026 12:06:55 +0200
In-Reply-To: <f012ef660c71e5d85bd746caab2f6a6e456671de.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
													 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
											 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
										 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
									 <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
								 <dc5f1cfb267b0fb522b8aaa236b71b23e236df4d.camel@web.de>
							 <4af8467060c5ee136c2b99ab855a007fec4e8c6c.camel@web.de>
				 <6e0b713cffd64b3c30eb4ff04e50721bac9cf8ca.camel@web.de>
	 <f012ef660c71e5d85bd746caab2f6a6e456671de.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NzR6scvkhKCtq+EdxYYLxvPyzE1IOyWonsb4ix7/ISaAVr8IZH8
 lElL53TJSY82R8RWJd/KIV0SbSTLAQiel1f1E/ZmcR5agg7N/TFe75mqdP1ZCievtoVykQn
 crXntN0eVYHbtOH3wWmWj6JfF+FYuU3773Lb+64mxy8wMTdc/JI1C0GFI7guBZ5rFsDi/hx
 1JjBfgPn+kGThRoAudMYw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y2CVzL9hLsM=;u8OwKDe8sIEzHDmV/9TGVhSAhhZ
 MDt13WQAPrfnAw9F+DTwcrcaXGjH3Xa2SM6DyQaa88ukEvttpy7ABxQTHIHeR+vjiOee4gQis
 8rmDR2KGeHgaqZtLh9t8i1e5kjUfgHyHeiX1l0UsE8uXqDpebKx06Q8ZygF40TOY0J+zdZLzK
 6CGgcUhoKFItOFfBlsJixMCPwWAmCstqtPZkZ/JyuXz3X8T1jtYoUm6eN6pmbHbsA49bPA3X3
 XkrVXLhH2zm0nuJBwfmT/ekjbzrZ/yDO7TVRmBC605b3/Hgr5LRmoEm6dWoVk6ZDQx85MoGLs
 tG/0mOEnRNeeJlmDQ9MWv+BB5DMZGC3O/Eb/CcvaMr3fRjpleRvthDdt7lX+B25AAZM/BRppD
 s+heT8Ea+IZ66PpYNYd0tyEfC+2qh1dKcPGxCeGHh8GGi2B4GrXoCdMNXYey5mSt37XaSEQNI
 VbYmxiqFFyfFsYNISz7O+uAI43IOYBnDqTeHlg8FKvgN4cDfHeXVBT3272DhbSscJX19S1pmo
 qSl+FEZwZhkjwHfzMpKrLnjp2Q8ud3WAVOAJJhQq24B/PcBuPMHrymYIYBUZM/DG1FZ+oXlwu
 VKQzgTfgZNN/W74jJG8fM2btPNE4H8blwPNcIckStfsX3nRnB6OdzRYRiRoS/nuZXDwBAHGwq
 8pQ1WNUtn/fzl7BtYojVxPIDetKgdfHOlsLAjbt3c4SYd2ICnqTuz3G/Dza5rqViu7ZmaOBdH
 a4lBWy64kMuXrcPQrJQxLyP1l3cgkmFba+KelRNfuGBPd9RMoOkV321BiQj4JUstV7toINNU/
 xSG4VT2yaZKM2VBEigN52YSQwIj8BkMrCicMiZ2jaLi/ddYB1E8Hgo31kj2HnKDLsupKe2nez
 p4WCDMA3Ouf6XekOEqwJTVOLEFotlAZ8AVUWY2OcYjVACODMQwOsfnbeKN+8ADlW0dS+Y7bUU
 rk9exMZsGyKSQVaeByuHyVqfzMxFwwe1N9i/HAwN2xco45hY1L81ohHwEnKiB9YaImqXvOYEb
 PFfaeklrP642fKdwm7D1QR+vLUtk13FoBSeY5yeozavfkX7W0igPRSuF26rtlkHLmMZqB1TS/
 rvkWy08ZIjtHTLZmGhVcU+nBwQ/yFxkkm2Jid19W4b7NtXY8W5O3JoVsIIaMVfpOHuqDcMDTr
 ClXJOLIlbt2L28O/vGf2Fr0gOl2ux2gDwoJQIoJWPf+6jyDwXl4RVCAmG+AZQw1Jskg1Sd4Y2
 tp6W3oUaCGc6SqnEjtj6Qa1GIL21/nfupO0Dc4nl+vRhiThbjpFI2GLWTsZ1aACNv+6pPP+RG
 zU6DcGQw0HasdDp6V8gNb8pOP2by5gCiXA1Ye6lxTyy7Wf3uqL075D/yx4UBXhySr4kgzokh6
 6MVATjOVFFI8oZmxBCtHYYqdpJVYYpZk5AQR0EnKQix22RpGANsNsb+rTMQpYkpCdNPsu93HZ
 xy5fu9obEjZRFivuV+ZLgjR7r89Mp8ry9jw0LiouBl86yJ03DESH4n7JzSKRngq8tWhGKpeah
 C/D2cg/UuL4w/8bpkwMPYZUJLM2cWxOgN9PLe+BuBX9huThL0O1kY/nNPL42vPC1UWOyyN6Uo
 kAeZW97HCrk2WOvYJKq+07YTjWCNqTOYSQfvyf0Whl2guWmYSfFDuB7pDc9u65E4xHBRSRbIO
 Vf7JsV4/7kazRvr5SnQ+1O/HUgz+7L/vKRoUH4rQ3ykDNrzRj8jqO/hsroEQKWqp2HozhhTup
 qwvi0gj1PcrLLZ6A67RwqYEUgyqrn34I7akUJIjziFlAXDEwRUvcqjcycIyyYfw9D81SbL0Pw
 esUEw76NmNNLOxpPeFyf+D6XsxvTGiK0PcVl8Fosc4EIS5oahmzJEkVDSpkTm/MTCVegn2uVu
 HERiJaK751cKn3rgwqb6Y9elOelky8G/1NxTY4gNo86YeSNXqcm6lXyBi7BvXR2Fh9Ed9Shuc
 5z2N5lIhtPv5I5EnOm8Kf+qzceBK7z3PBiS+GUdjrR4g40h9gogSAxY+OHGUjwD5DoNfhZ97r
 WddgOkNsWTNBv2mkxJXA+knt/nqgpF/sCvNHyrEGLNgk5kVIHp2L+HwKTaDhDPn1vjbjBqjgI
 6rRM7VZAGDj2fk/5Ei9Zzst7HLSYZRK5ccvt0A+DNTCD3bFVxUIPIg2pfWcLsOqy5zM8CBhd3
 AK0clXWU/teNnDgwfFFuzi5ykuTPt506ZWddbOXlaECwEVfawVZRrET96FKHAo1E8kPsVaU0m
 sriFnLPqS8+jZhUdCwyhH51SC08nO7P3kKVOD2Vt5UDap+0v/nTMoRSjCDLVYmG/lVgTDvfKe
 /TuYCQm9i+d6iKVk1nRXp+t3MdtGUCKJ8HtANPS+nFFNd4JjHMIaepkRTC8uvUEx4qgMif8t8
 xKhbUZYQmJIcgKEtybCqxDLZZ38TKt3+E6ZcOfHfhrTSdudu8h18vFvqgBkHJnoJpCBE4N/RU
 X/MdgB7EWTHWDTkRFpdVKc3fLJjf5dFZfhpqhuAur6Bl4VH0Vjpjy3gPVz1LHD1Qc8AZ8F/dk
 k1pTdWB5x/pC4KSTYhRUzMON2uiPF6TfDPgBKzjYXa6iPLEapusxkm/M9It2Cc/sjI/RYm7Cy
 8H535UxR2CY0jb+WUkXQF4k3tbTI4s6KZD4cNeMFkNG0FjTlFCASwhXaIZWz1glFdOET4JrIX
 KfGkZS9h2g6YQFbLk4/Y/GKycWTWE+24fPvKSIUsRLceR2avDxIYlaPPY9YIFC4Df3jAFK3Ow
 QpDzQM3qtn5ZnYwtFwOPdQNhvMwoN7B78XgKd3Pv27+tL9d+N9PAtW+q/20s5hkUYS8jLvKHb
 XjWCgA3VRd9+2ZNXXpvbiKgZcj5XE2r1R9b+z4ng2ogt5LoyZxZmcZ2n49FoeKvLPLpn99ZPt
 FEPUh1LFXcVf1nKiNmPIGy6lgXE/aJ1dTKRQ6FJ/tO3aIFlK6qw0xIkAg3jWV9QH9ail2QD+R
 /2ZHVjeTE/KxRyeQGapIynqBY5I7iifjHEDlW1VwZ5lyU8ZCktkQD2m96rKjxV7bm0muj9aPc
 qLVp6Vq76Rsyi9VmOOxQ0RuCv/1n5B7WGGo2cWoOEJQhOYHQ8jBiSyWVv049zpH8arHhlAmnz
 OqMYqF0SIV5nhu1XVr/RbdQ1kNfffWlk0sYMQyqIGaOW725yUply7DL82+oSsWE78mg4wzm/w
 TUALW8E7HY8AATCEn22uF8Pybb4OTHJ2rJP0UDmlfX/LTu4K6BcCSCp5jUwLPg1UB6QBQVpwn
 xkFdLRDKR5vL9PDOXfCNhRZvnSejVKqhfUCw+mJbdCSC6BFLMgGjfGSzB/vLhHS6tiQx0Q6NJ
 k/gWEQPI0Ti+mROWToBD5B42PKv1+pcxTYUz490gGz6qeHNZEEXCsgymLx0CRfsfq6q1b5DKf
 f1Lmk9aZ1vi5fpiGNryckJO3D31UT+7t/vso1OLf0/UxCeE02zc80mS3vIveK0oyFrsqdJZ+L
 PR8rCi77uiTvkJJGwaI94rVoqRGt+KwdKbz1r55pPF5JYYc6XK9qUsdm3PPNIRyf9WWfW38C3
 1a8IbNaZ4Mk2y1UkgAan7JxNM5yom21r6vEsEAGa5nU8HP05MtoSU/6Gj+JIJYGKGEGDO2+Xb
 owWikrLQYBFCZN+QMqAXA8v9bncjKW2+oMCeGoo5VpT9TLBcJUhia2M0EGtWOWq0CwSNvluN2
 WJ9IaAj0TbFI/tsARBeQu3k5Xt1uKTH9rnbz37M9qInmVzsWQi5qQpLJWqi+PIBkYtt25F+5u
 URpbK9HZtPX0hy21J8DBbEmQ1JCJoDFoeZfA1uw+ZKb9X6pcNExORlvwY/S/OCqSXedu4q+Dk
 rUW/rR37nvn2Bb6I65PO0h0vWIcxEXtjL4tZDem2Cytjm8QWnAqiKOWTrHydwfsBgKpNMH5yP
 MFgLHyAYbIWd2RRslBuT2/F5M/biaGsgybtqk7cV9cFPhYVHzkZkk54J29XOVBA3dD04Xht0a
 fYFsjqRATgJwq74nlmpm7valg6eCTKJSEzVCk/lb+QhlnNcZHTToYTFCwSS8gwXEJAQOyQIIX
 OB3ONufnLTzBZg777zD2AuLNKrMTJgthSrVFnMIeBbDRpmTlshkQ7sgXYOz+1ZJPcn6lhrTbm
 Ov/EAccliH1qdke5YhYMlwBiieZD0Uaa9CpfVz9dcGqpo2GBAz3rH7ZmeIH0P9lXBhMFimW4u
 ZtvJP/NtuH/64DFzyUQAsjH/mcnGSdstBEprW9yEE0BuJWBkRoYvKpY10DTrEQKpeK70lT2E5
 XyYEblxcMNb0tsSB/3xesjiRNp0Og+UfUBM/hk5XIOAs7d3Tp7LZjbM74cwLZDnvfXeeiFcOs
 wpsHr0D4T3Dx21dzo4tmOtVRPo1UmTEckW1ibUW6AMJtlskk9Us1TIjwZ4FDPK5LHx+EZSa3l
 nZnaZf0MQ2Fhr5rU8+nNCPij0tpyYXh3iLRrS1gCxy7wm+XVLcLv2gw/f/5bvSPMXC3iHQGbd
 9h8yY1TgIsnYKU4qz4p2cWXf9Pk871CgXoLJtYuEY1XPgWrlbUF0S5Jn8IFzePh/Xot+yCRq+
 Y5fvsHXGKbTqdcJOokc2Of1HrBaFGBWaF5DW+rZVZnTGU7pvGQbiOrVMbmF+bJRMQRmjXeL/q
 EAIKRwWZcGVQBq9KswflHg9lXWmW/zMN6wwe4uKcx4wph/NFdiw4rAoAE/736UkwFw70pxIKZ
 OkpWRyhTuquh8d+Y3PRQTSDry/XjlBSAdqkTTkbIMEl6B/oB37PNCjmDg4tGAYUweDjNoTAMa
 dXkQgmxkujTaerfRtm5XQ9f29O+cFrdWj2G2HFlS4OW6N8CdrEUeRXDMavxfAggAgY7HtU8U2
 Fa4gEIAyoYFVm3w3KATrywe5bz02HiSjagGt8H1QcU3jji9ns0T8GIFtwwcLJIDKFQSCuFo4K
 tZw41MlkOZP1v12KUkKHH6O+20148M+lm+loqKQ9lFz5o0efEn4HVWCd6wQjn+HAi5/NfPEOK
 KB4q9Ep7K82+cQMOErReDVbtH/XSmWKup/d+g36tjTecvWiQj5UG7d0E/FzwjzQ2XNp/8v7ek
 ytDFQKIU7nHHU1cQ4eS72aBuc/6eRkbkUiMOPANzDPEhtgQ/ND7Z867YvsQapv5Cz+OCfTwi2
 OY4Bk6+jF8N/oWtDT36HQtHpasASX3T0kuw34TVdlTUi+3olUdQ1sx0hn0xjdVSPIVadhDXyv
 a7WyZJfORk1LcOiQ2DmpMcIwX48i8ffi/7a819FkkA6dU/xIpe9HPXAnGLDEG3fl0ue+nC0In
 Qo8agRaj6iCv8wr6aWJkX2CDbsDONWagWphhexLc8APdDp9wdTsbsexwvBO0V9CNm7c5kXwi2
 Ek62W0WsK2qJB8yRGBU+Yihe+vcj+tn9cfy9jLyjWiP9o9paLPWOSPkhPq+/rhWbd+95lRjR7
 uPCDI8oSyOVjbNk5h5S2+n3HX5xDSIQBcJ89Vnq17A2YYyIxGR4KzRA3kcGnEccg8+MCRrRCL
 kS3pKmx1Syd6X1v0JVCgCxwk27bQOrMHrSSihaz+TdQfxUYe7cv6enxpP/q74GCzT1cRyeNOV
 /ysyvTPCIpeeoqVSTrWTjHq+Xdy/ZJk/0hb2fc6ggwXvycTRONcuVQ0dpx3Ebz2eYGO9BsO3a
 lSq7q3jCGxwBB/CyLzhuutDRue7MtGIRGSHP43gwPGlVb6ECo28xfDimm1BAQ==

This can be fixed like this

struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
{
	struct dc_plane_state *plane_state;
	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state = kvzalloc_obj(*plane_state, GFP_ATOMIC));

	if (NULL == plane_state)
		return NULL;

	kref_init(&plane_state->refcount);
	dc_plane_construct(dc->ctx, plane_state);

	return plane_state;
}

I also found missing DC_RUN_WITH_PREEMPTION_ENABLED in an error path, I'm preparing
a patch for next-20260721 (next-20260722+ have broken reboot due to the mt7925 issue
mentioned above).
 Also, is preempt_{disable,enable}() really necessary in DC_FPU_{BEGIN,END}?
Could migrate_{disable,enable}() be enough instead? This way we wouldn't need
DC_RUN_WITH_PREEMPTION_ENABLED at all(?).

Bert Karwatzki
